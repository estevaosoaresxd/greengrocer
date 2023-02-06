import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/cart/components/cart_tile.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CardTab extends StatefulWidget {
  const CardTab({Key? key}) : super(key: key);

  @override
  State<CardTab> createState() => _CardTabState();
}

class _CardTabState extends State<CardTab> {
  UtilsServices utilsServices = UtilsServices();

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
      ),
      body: Column(
        children: [
          // ignore: prefer_const_constructors
          Expanded(
            child: GetBuilder<CartController>(
              builder: (controller) {
                if (controller.cartItems.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart,
                        size: 40,
                        color: CustomColors.customSwatchColors,
                      ),
                      const Text(
                        "Não há itens no carrinho",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  );
                }

                return ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      return CardTile(
                        cartItems: controller.cartItems[index],
                      );
                    });
              },
            ),
          ),

          // BOTTOM BUTTON AND VALUE
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Total geral",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                GetBuilder<CartController>(
                  builder: (controller) {
                    return Text(
                      utilsServices.priceToCurrency(
                        controller.getTotalPrice(),
                      ),
                      style: TextStyle(
                        fontSize: 23,
                        color: CustomColors.customSwatchColors,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: GetBuilder<CartController>(
                    builder: (controller) => ElevatedButton(
                      onPressed: controller.isLoadingCheckout ||
                              controller.cartItems.isEmpty
                          ? null
                          : () async {
                              bool? result = await showOrderConfirmation();

                              if (result ?? false) {
                                if (context.mounted) {
                                  await cartController.checkoutCart();
                                }
                              } else {
                                utilsServices.showToast(
                                  message: "Pedido não confirmado",
                                  error: true,
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.customSwatchColors,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: controller.isLoadingCheckout
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Concluir Pedido",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
        context: context,
        builder: ((context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text("Confirmação"),
            content: const Text("Deseja realmente concluir o pedido?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text(
                  "Não",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Sim"),
              )
            ],
          );
        }));
  }
}
