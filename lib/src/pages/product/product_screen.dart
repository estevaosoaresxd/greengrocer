import 'package:flutter/material.dart';

// PACKAGES
import 'package:get/get.dart';

// COLORS
import 'package:greengrocer/src/config/custom_colors.dart';

// CONTROLLER
import 'package:greengrocer/src/pages/base/controller/navigation_controller.dart';
import 'package:greengrocer/src/pages/product/controller/product_controller.dart';

// WIDGET
import 'package:greengrocer/src/pages/widgets/quantity_widget.dart';

// SERVICES
import 'package:greengrocer/src/services/utils_services.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UtilsServices utilsServices = UtilsServices();

  int cartItemQuantity = 1;

  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          GetBuilder<ProductController>(builder: (controller) {
            return Column(
              children: [
                Expanded(
                  child: Hero(
                    tag: controller.item.picture,
                    child: Image.network(
                      controller.item.picture,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade600,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Name - Quantidade
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.item.title,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            QuantityWidget(
                              isRemovable: true,
                              suffixText: controller.item.unit,
                              value: cartItemQuantity,
                              result: (int quantity) {
                                setState(() {
                                  cartItemQuantity = quantity;
                                });
                              },
                            )
                          ],
                        ),

                        // Price
                        Text(
                          utilsServices.priceToCurrency(controller.item.price),
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.customSwatchColors,
                          ),
                        ),

                        //Description
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Text(
                                controller.item.description,
                                style: const TextStyle(
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Button
                        SizedBox(
                          height: 55,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              Get.back();

                              navigationController.navigatePageView(
                                NavigationTabs.cart,
                              );
                            },
                            label: const Text(
                              "Adicionar ao Carrinho",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            icon: const Icon(
                              Icons.shopping_cart_checkout_outlined,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }),

          // BACN BUTTON
          Positioned(
            top: 10,
            left: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
