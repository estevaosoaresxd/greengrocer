import 'package:get/get.dart';
import 'package:greengrocer/src/pages/orders/controller/all_orders_controller.dart';

class OrdersBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      AllOrdersController(),
    );
  }
}
