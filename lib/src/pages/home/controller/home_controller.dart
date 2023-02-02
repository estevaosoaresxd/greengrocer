import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/repository/home_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();

  bool loadingCategory = false;
  bool loadingProduct = true;

  List<CategoryModel> categories = <CategoryModel>[];

  List<ItemModel> get products => selectedCategory?.items ?? [];

  RxString searchTitle = "".obs;

  bool get isLastPage =>
      selectedCategory!.items.length < itemsPerPage ||
      (selectedCategory!.pagination * itemsPerPage) >
          selectedCategory!.items.length;

  CategoryModel? selectedCategory;

  @override
  void onInit() async {
    super.onInit();

    debounce(
      searchTitle,
      (callback) => filterByTitle(),
      time: const Duration(milliseconds: 600),
    );

    await getAllCategories();
  }

  void setLoading(bool value, {required bool isProduct}) {
    isProduct ? loadingProduct = value : loadingCategory = value;

    update();
  }

  void filterByTitle() {
    for (var category in categories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      categories.removeAt(0);
    } else {
      CategoryModel? c = categories.firstWhereOrNull(
        (cat) => cat.id == '',
      );

      if (c == null) {
        final allCategory = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );

        categories.insert(0, allCategory);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }

    selectedCategory = categories.first;

    update();

    getAllProducts();
  }

  Future<void> selectCategory(CategoryModel category) async {
    selectedCategory = category;

    update();

    if (selectedCategory!.items.isNotEmpty) {
      return;
    }

    await getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true, isProduct: false);

    final res = await homeRepository.getAllCategories();

    setLoading(false, isProduct: false);

    res.when(
      success: (data) {
        categories.assignAll(data);

        if (data.isNotEmpty) {
          selectCategory(data.first);
        }
      },
      error: (error) {
        UtilsServices().showToast(message: error, error: true);
      },
    );
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> body = {
      "page": selectedCategory?.pagination ?? 0,
      "categoryId": selectedCategory?.id,
      "itemsPerPage": itemsPerPage,
    };

    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;

      if (selectedCategory?.id == '') {
        body.remove('categoryId');
      }
    }

    final res = await homeRepository.getAllProducts(body);

    setLoading(false, isProduct: true);

    res.when(
      success: (data) {
        selectedCategory?.items.addAll(data);

        update();
      },
      error: (error) {
        UtilsServices().showToast(message: error, error: true);
      },
    );
  }

  void loadMoreProducts() async {
    selectedCategory!.pagination++;

    getAllProducts(canLoad: false);
  }
}
