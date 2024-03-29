import 'package:get/get.dart';
import 'package:greengrocer/src/pages/base/controller/navigation_controller.dart';

class NavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => NavigationController(),
    );
  }
}
