import 'package:flutter/material.dart';
import 'package:get/get.dart';

//APP DATA

// COLORS
import 'package:greengrocer/src/config/custom_colors.dart';

// PACKAGES
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart' as badges;
import 'package:greengrocer/src/pages/home/controller/home_controller.dart';
import 'package:greengrocer/src/pages/home/view/components/category_title.dart';

// COMPONENTS
import 'package:greengrocer/src/pages/home/view/components/item_tile.dart';
import 'package:greengrocer/src/pages/widgets/app_name_widget.dart';
import 'package:greengrocer/src/pages/widgets/custom_shimmer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();

  final searchController = TextEditingController();

  late Function(GlobalKey) runAddToCardAnimation;

  void itemSelectedCardAnimations(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const AppNameWidget(fontWeight: true),
        actions: [
          // Cart Button
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: GestureDetector(
              onTap: () {},
              child: badges.Badge(
                badgeColor: CustomColors.customConstrastColors,
                badgeContent: const Text(
                  "2",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                child: AddToCartIcon(
                  key: gkCart,
                  icon: Icon(
                    Icons.shopping_cart,
                    color: CustomColors.customSwatchColors,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      // BODY
      body: AddToCartAnimation(
        gkCart: gkCart,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCardAnimation = addToCardAnimationMethod;
        },
        child: Column(
          children: [
            // Search Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GetBuilder<HomeController>(
                builder: (controller) {
                  return TextFormField(
                    onChanged: (e) => controller.searchTitle.value = e,
                    controller: searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      hintText: 'Pesquisa aqui...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: CustomColors.customConstrastColors,
                        size: 21,
                      ),
                      suffixIcon: controller.searchTitle.value.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.close,
                                color: CustomColors.customConstrastColors,
                                size: 21,
                              ),
                              onPressed: () {
                                searchController.clear();
                                controller.searchTitle.value = "";
                                FocusScope.of(context).unfocus();
                              })
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
                  );
                },
              ),
            ),

            GetBuilder<HomeController>(
              builder: (controller) {
                return Container(
                  height: 40,
                  padding: const EdgeInsets.only(left: 25),
                  child: !controller.loadingCategory
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((_, index) {
                            return CategoryTile(
                              category: controller.categories[index].title,
                              isSelected: controller.categories[index] ==
                                  controller.selectedCategory,
                              onPressed: () {
                                controller.selectCategory(
                                  controller.categories[index],
                                );
                              },
                            );
                          }),
                          separatorBuilder: (_, index) => const SizedBox(
                                width: 10,
                              ),
                          itemCount: controller.categories.length)
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            5,
                            (index) => Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 12),
                              child: CustomShimmer(
                                height: 20,
                                width: 60,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),

            // CATEGORYS
            // Grid
            GetBuilder<HomeController>(
              builder: (controller) {
                return Expanded(
                  child: !controller.loadingProduct
                      ? Visibility(
                          visible: (controller.selectedCategory?.items ?? [])
                              .isNotEmpty,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 40,
                                color: CustomColors.customSwatchColors,
                              ),
                              const Text(
                                "Não há produtos para apresentação.",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 9 / 11.5,
                            ),
                            itemCount: controller.products.length,
                            itemBuilder: (_, index) {
                              if ((index + 1) == controller.products.length &&
                                  !controller.isLastPage) {
                                controller.loadMoreProducts();
                              }

                              return ItemTile(
                                item: controller.products[index],
                                cartAnimationMethdod:
                                    itemSelectedCardAnimations,
                              );
                            },
                          ),
                        )
                      : GridView.count(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 9 / 11.5,
                          children: List.generate(
                            10,
                            (index) => CustomShimmer(
                              height: double.infinity,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
