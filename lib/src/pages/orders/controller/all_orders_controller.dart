import 'package:get/get.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controlller.dart';
import 'package:greengrocer/src/pages/orders/repository/orders_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AllOrdersController extends GetxController {
  List<OrderModel> orders = [];

  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilServices = UtilsServices();

  @override
  void onInit() {
    super.onInit();

    getAllOrders();
  }

  Future<void> getAllOrders() async {
    final result = await ordersRepository.getAllOrders(
      token: authController.user.token,
      userId: authController.user.id,
    );

    result.when(
      success: (data) {
        orders = data
          ..sort(
            (a, b) => b.createdDateTime!.compareTo(a.createdDateTime!),
          );
        update();
      },
      error: (message) {
        utilServices.showToast(message: message, error: true);
      },
    );
  }
}
