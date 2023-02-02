import 'package:get/get.dart';
import 'package:greengrocer/src/models/item_model.dart';

class ProductController extends GetxController {
  late ItemModel item;

  @override
  void onInit() {
    item = Get.arguments;
    super.onInit();
  }
}
