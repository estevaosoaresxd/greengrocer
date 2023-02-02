import 'package:get/get.dart';

// PAGES
import 'package:greengrocer/src/pages/product/product_screen.dart';
import 'package:greengrocer/src/pages/splash/splash_screen.dart';
import 'package:greengrocer/src/pages/auth/view/sign_in_screen.dart';
import 'package:greengrocer/src/pages/auth/view/sign_up_screen.dart';
import 'package:greengrocer/src/pages/base/base_screen.dart';

// BINDING
import 'package:greengrocer/src/pages/base/binding/navigation_binding.dart';
import 'package:greengrocer/src/pages/cart/binding/cart_binding.dart';
import 'package:greengrocer/src/pages/home/binding/home_binding.dart';
import 'package:greengrocer/src/pages/product/binding/product_binding.dart';

abstract class AppRoutes {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.signInRoute,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: PagesRoutes.signUpRoute,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const BaseScreen(),
      bindings: [
        HomeBinding(),
        NavigationBinding(),
        CartBinding(),
      ],
    ),
    GetPage(
      name: PagesRoutes.productRoute,
      page: () => const ProductScreen(),
      binding: ProductBinding(),
    ),
  ];
}

abstract class PagesRoutes {
  static const String splashRoute = "/splash";
  static const String signInRoute = "/signin";
  static const String signUpRoute = "/signup";
  static const String productRoute = "/product";
  static const String baseRoute = "/";
}
