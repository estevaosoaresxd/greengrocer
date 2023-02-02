const String baseUrl = "https://parseapi.back4app.com/functions";

abstract class EndPoints {
  static const String signIn = '$baseUrl/login';
  static const String signUp = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/validate-token';
  static const String resetPassword = '$baseUrl/reset-password';
  static const String getAllCategories = '$baseUrl/get-category-list';
  static const String getAllProducts = '$baseUrl/get-product-list';
  static const String getCartItems = '$baseUrl/get-cart-items';
  static const String addItemToCart = '$baseUrl/add-item-to-cart';
  static const String modifyItemQuantity = '$baseUrl/modify-item-quantity';
}
