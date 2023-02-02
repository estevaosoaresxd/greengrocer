import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/pages/cart/result/cart_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List>> getCartItems({
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
      // List<CategoryModel> data =
      //     (List<Map<String, dynamic>>.from(result['result']))
      //         .map(CategoryModel.fromJson)
      //         .toList();

      return CartResult<List>.success([]);
    } else {
      return CartResult.error(
        'Ocorreu um erro inesperado ao recuperar os itens do carrinho.',
      );
    }
  }
}
