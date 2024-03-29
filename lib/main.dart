import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// PACKAGES
import 'package:get/get.dart';

import 'package:greengrocer/src/pages/auth/controller/auth_controlller.dart';

// ROUTES
import 'package:greengrocer/src/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(
    AuthController(),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppRoutes.pages,
    );
  }
}
