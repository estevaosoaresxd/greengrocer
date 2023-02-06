import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controlller.dart';
import 'package:greengrocer/src/pages/widgets/custom_text_field.dart';
import 'package:greengrocer/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do usuário"),
        actions: [
          IconButton(
            onPressed: () => authController.signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          // EMAIL
          CustomTextField(
            icon: Icons.email,
            labelText: "E-mail",
            initialValue: authController.user.email,
            readOnly: true,
          ),
          // NAME
          CustomTextField(
            icon: Icons.person,
            labelText: "Nome",
            initialValue: authController.user.fullname,
            readOnly: true,
          ),
          // PHONE
          CustomTextField(
            icon: Icons.phone,
            labelText: "Celular",
            initialValue: authController.user.phone,
            readOnly: true,
          ),
          // CPF
          CustomTextField(
            icon: Icons.copy,
            labelText: "CPF",
            isSecret: true,
            initialValue: authController.user.cpf,
            readOnly: true,
          ),

          // BUTTON
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                await showChangePassword();
              },
              child: const Text(
                "Atualizar Senha",
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> showChangePassword() {
    final formKey = GlobalKey<FormState>();

    final newPasswordController = TextEditingController();
    final currentPasswordController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // TITLE
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            "Atualização de Senha",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // PASSWORD
                        CustomTextField(
                          icon: Icons.lock,
                          labelText: "Senha Atual",
                          isSecret: true,
                          validator: passwordValidator,
                          controller: currentPasswordController,
                        ),

                        // NEW PASSWORD
                        CustomTextField(
                          icon: Icons.lock_outline,
                          labelText: "Nova Senha",
                          isSecret: true,
                          validator: passwordValidator,
                          controller: newPasswordController,
                        ),

                        // CONFIRM PASSWORD
                        CustomTextField(
                          icon: Icons.lock_outline,
                          labelText: "Confirmar Nova Senha",
                          isSecret: true,
                          validator: (password) {
                            final res = passwordValidator(password);

                            if (res != null) {
                              return res;
                            }

                            if (password != newPasswordController.text) {
                              return 'As senhas não são equivalentes.';
                            }

                            return null;
                          },
                        ),

                        // CONFIRMATION BUTTON
                        SizedBox(
                          height: 45,
                          child: Obx(() => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          authController.changePassword(
                                            currentPassword:
                                                currentPasswordController.text,
                                            newPassword:
                                                newPasswordController.text,
                                          );
                                        }
                                      },
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "Atualizar",
                                      ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                )
              ],
            ),
          );
        });
  }
}
