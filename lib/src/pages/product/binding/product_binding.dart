import 'package:get/get.dart';
import 'package:greengrocer/src/pages/product/controller/product_controller.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      ProductController(),
    );
  }
}
