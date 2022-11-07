import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/app_data.dart';
import 'package:greengrocer/src/pages/widgets/custom_text_field.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do usuário"),
        actions: [
          IconButton(
            onPressed: () {},
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
            initialValue: user.email,
            readOnly: true,
          ),
          // NAME
          CustomTextField(
            icon: Icons.person,
            labelText: "Nome",
            initialValue: user.fullname,
            readOnly: true,
          ),
          // PHONE
          CustomTextField(
            icon: Icons.phone,
            labelText: "Celular",
            initialValue: user.phone,
            readOnly: true,
          ),
          // CPF
          CustomTextField(
            icon: Icons.copy,
            labelText: "CPF",
            isSecret: true,
            initialValue: user.cpf,
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
                      const CustomTextField(
                        icon: Icons.lock,
                        labelText: "Senha Atual",
                        isSecret: true,
                      ),

                      // NEW PASSWORD
                      const CustomTextField(
                        icon: Icons.lock_outline,
                        labelText: "Nova Senha",
                        isSecret: true,
                      ),

                      // CONFIRM PASSWORD
                      const CustomTextField(
                        icon: Icons.lock_outline,
                        labelText: "Confirmar Nova Senha",
                        isSecret: true,
                      ),

                      // CONFIRMATION BUTTON
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text(
                            "Atualizar",
                          ),
                        ),
                      )
                    ],
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
