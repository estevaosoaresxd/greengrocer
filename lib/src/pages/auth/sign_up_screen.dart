import 'package:flutter/material.dart';

// WIDGET
import 'package:greengrocer/src/pages/widgets/custom_text_field.dart';

// THEME
import 'package:greengrocer/src/config/custom_colors.dart';

// PACKAGE
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );
  final phoneFormatter = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColors,
      body: SingleChildScrollView(
        reverse: true,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Cadastro",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Form
                        const CustomTextField(
                          icon: Icons.email,
                          labelText: 'E-mail',
                        ),
                        const CustomTextField(
                          icon: Icons.lock,
                          labelText: 'Senha',
                          isSecret: true,
                        ),
                        const CustomTextField(
                          icon: Icons.person,
                          labelText: 'Nome',
                        ),
                        CustomTextField(
                          icon: Icons.phone,
                          labelText: 'Celular',
                          inputFormatters: [phoneFormatter],
                        ),
                        CustomTextField(
                          icon: Icons.file_copy,
                          labelText: 'CPF',
                          inputFormatters: [cpfFormatter],
                        ),

                        //  Tegister Button
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Cadastrar usuário",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 10,
                top: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
