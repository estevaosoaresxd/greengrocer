import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controlller.dart';
import 'package:greengrocer/src/pages/cart/repository/cart_repository.dart';
import 'package:greengrocer/src/pages/widgets/payment_dialog.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilServices = UtilsServices();

  bool isLoadingCheckout = false;

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  Future<void> getCartItems() async {
    final result = await cartRepository.getCartItems(
      token: authController.user.token,
      userId: authController.user.id,
    );

    result.when(
      success: (data) {
        cartItems = data;
        update();
      },
      error: (message) {
        utilServices.showToast(message: message, error: true);
      },
    );
  }

  Future<void> addItemToCart({
    required ItemModel item,
    int quantity = 1,
  }) async {
    int index = getItemIndex(item);

    if (index >= 0) {
      await cartRepository.setQuantityItem(
        cartItemId: cartItems[index].id,
        token: authController.user.token,
        quantity: (cartItems[index].quantity + quantity),
      );
    } else {
      final result = await cartRepository.addItemsToCart(
        token: authController.user.token,
        userId: authController.user.id,
        productId: item.id,
        quantity: quantity,
      );

      result.when(
        success: (id) {
          cartItems.add(
            CartItemModel(
              item: item,
              quantity: quantity,
              id: id,
            ),
          );
        },
        error: (message) {
          utilServices.showToast(message: message, error: true);
        },
      );
    }

    update();
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.setQuantityItem(
      cartItemId: item.id,
      token: authController.user.token,
      quantity: quantity,
    );

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((e) => e.id == item.id);
      } else {
        cartItems.firstWhere((e) => e.id == item.id).quantity = quantity;
      }

      update();
    } else {
      utilServices.showToast(
        message: 'Ocorreu um erro ao alterar a quantitade do produto',
        error: true,
      );
    }

    return result;
  }

  Future<void> checkoutCart() async {
    setLoading(true);

    final result = await cartRepository.checkoutCart(
      token: authController.user.token,
      total: getTotalPrice(),
    );

    setLoading(false);

    result.when(
      success: (data) {
        cartItems.clear();

        update();

        showDialog(
          context: Get.context!,
          builder: (_) => PaymentDialog(
            order: data,
          ),
        );
      },
      error: (message) {
        utilServices.showToast(message: message, error: true);
      },
    );
  }

  void setLoading(bool value) {
    isLoadingCheckout = value;
    update();
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere(
      (itemList) => itemList.item.id == item.id,
    );
  }

  double getTotalPrice() {
    double total = 0.0;

    for (var item in cartItems) {
      total += item.totalPrice();
    }

    return total;
  }
}
