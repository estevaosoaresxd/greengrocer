import 'package:get/get.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CartController(),
    );
  }
}
