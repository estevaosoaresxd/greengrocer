import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/cart/result/cart_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems({
    required String? token,
    required String? userId,
  }) async {
    final result = await _httpManager.request(
      url: EndPoints.getCartItems,
      method: HttpMethods.post,
      headers: {
        "X-Parse-Session-Token": token,
      },
      body: {
        "user": userId,
      },
    );

    if (result['result'] != null) {
      List<CartItemModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CartItemModel.fromJson)
              .toList();

      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult.error(
        'Ocorreu um erro inesperado ao recuperar os itens do carrinho.',
      );
    }
  }

  Future<bool> setQuantityItem({
    required String? cartItemId,
    required String? token,
    required int? quantity,
  }) async {
    final result = await _httpManager.request(
      url: EndPoints.modifyItemQuantity,
      method: HttpMethods.post,
      headers: {
        "X-Parse-Session-Token": token,
      },
      body: {
        "quantity": quantity,
        "cartItemId": cartItemId,
      },
    );

    return result.isEmpty;
  }

  Future<CartResult<String>> addItemsToCart({
    required String? token,
    required String? userId,
    required String? productId,
    required int? quantity,
  }) async {
    final result = await _httpManager.request(
      url: EndPoints.addItemToCart,
      method: HttpMethods.post,
      headers: {
        "X-Parse-Session-Token": token,
      },
      body: {"user": userId, "quantity": quantity, "productId": productId},
    );

    if (result['result'] != null) {
      return CartResult<String>.success(result['result']['id']);
    } else {
      return CartResult.error(
        'Não foi possível adicionar o item no carrinho.',
      );
    }
  }

  Future<CartResult<OrderModel>> checkoutCart({
    required String? token,
    required double? total,
  }) async {
    final result = await _httpManager.request(
      url: EndPoints.checkout,
      method: HttpMethods.post,
      headers: {
        "X-Parse-Session-Token": token,
      },
      body: {
        "total": total,
      },
    );

    if (result['result'] != null) {
      final order = OrderModel.fromJson(result['result']);

      return CartResult<OrderModel>.success(order);
    } else {
      return CartResult.error(
        'Não foi possível finalizar o pedido.',
      );
    }
  }
}
