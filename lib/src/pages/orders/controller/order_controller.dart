import 'package:get/get.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controlller.dart';
import 'package:greengrocer/src/pages/orders/repository/orders_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderController extends GetxController {
  OrderModel order;

  bool isLoading = false;

  final orderRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilServices = UtilsServices();

  OrderController(this.order);

  Future<void> getOrderItems() async {
    setLoading(true);

    final result = await orderRepository.getOrderItems(
      token: authController.user.token,
      orderId: order.id,
    );

    setLoading(false);

    result.when(
      success: (data) {
        order.items = data;
        update();
      },
      error: (message) {
        utilServices.showToast(message: message, error: true);
      },
    );
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }
}
