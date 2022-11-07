import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controlller.dart';

// COMPONENTS
import 'package:greengrocer/src/pages/widgets/custom_text_field.dart';

//THEMES
import 'package:greengrocer/src/config/custom_colors.dart';

// ROUTES
import 'package:greengrocer/src/routes/app_routes.dart';

// PACKAGES
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

// WIDGET
import 'package:greengrocer/src/pages/widgets/app_name_widget.dart';
import 'package:greengrocer/src/services/validators.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColors,
      body: SingleChildScrollView(
        reverse: true,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // Logo App
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Name App
                  const AppNameWidget(
                    greenTitleColor: Colors.white,
                    textSize: 40,
                    fontWeight: true,
                  ),

                  // Categorys
                  SizedBox(
                    height: 30,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        pause: Duration.zero,
                        animatedTexts: [
                          FadeAnimatedText("Frutas"),
                          FadeAnimatedText("Verduras"),
                          FadeAnimatedText("Legumes"),
                          FadeAnimatedText("Carnes"),
                          FadeAnimatedText("Cereais"),
                          FadeAnimatedText("Laticíneos"),
                        ],
                      ),
                    ),
                  )
                ],
              )),

              // Form
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // E-mail
                      CustomTextField(
                        icon: Icons.email,
                        labelText: 'E-mail',
                        controller: emailController,
                        validator: emailValidator,
                      ),
                      CustomTextField(
                        icon: Icons.lock,
                        labelText: 'Senha',
                        isSecret: true,
                        controller: passwordController,
                        validator: passwordValidator,
                      ),

                      //  Login
                      GetX<AuthController>(
                        builder: (authController) {
                          return SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () async {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        await authController.signIn(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Entrar",
                                      style: TextStyle(fontSize: 18),
                                    ),
                            ),
                          );
                        },
                      ),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Esqueceu a senha?",
                            style: TextStyle(
                              color: CustomColors.customConstrastColors,
                            ),
                          ),
                        ),
                      ),

                      // Divider
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                color: Colors.grey.withAlpha(90),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text("Ou"),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                color: Colors.grey.withAlpha(90),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Create Account
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.toNamed(PagesRoutes.signUpRoute);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              width: 2,
                              color: Colors.green,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            "Criar Conta",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
