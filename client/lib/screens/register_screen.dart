import 'package:flutter/material.dart';
import 'package:todo_app_flutter_nodejs/screens/login_screen.dart';
import 'package:todo_app_flutter_nodejs/widgets/custom_buttons.dart';
import 'package:todo_app_flutter_nodejs/widgets/custom_text_field.dart';

import '../services/user_services/user_register_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Register",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.red,
      ),
      body: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: CustomTextField(
                      label: "Username",
                      enabled: true,
                      value: username,
                      suffixIcon: Icons.supervised_user_circle_rounded,
                      focusedBorderColor: Colors.red,
                      enabledBorderColor: Colors.red,
                      disabledBorderColor: Colors.red,
                      validator: FormValidator.validateName,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: CustomTextField(
                      label: "Email",
                      enabled: true,
                      value: email,
                      suffixIcon: Icons.email,
                      focusedBorderColor: Colors.red,
                      enabledBorderColor: Colors.red,
                      disabledBorderColor: Colors.red,
                      validator: FormValidator.validateEmail,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: CustomTextField(
                      label: "Password",
                      enabled: true,
                      value: password,
                      obscureText: true,
                      suffixIcon: Icons.remove_red_eye,
                      handleSuffixOnPressed: () => {},
                      focusedBorderColor: Colors.red,
                      enabledBorderColor: Colors.red,
                      disabledBorderColor: Colors.red,
                      validator: FormValidator.validatePassword,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: CustomTextField(
                      label: "Confirm Password",
                      enabled: true,
                      value: confirmPassword,
                      obscureText: true,
                      suffixIcon: Icons.remove_red_eye,
                      focusedBorderColor: Colors.red,
                      enabledBorderColor: Colors.red,
                      disabledBorderColor: Colors.red,
                      handleSuffixOnPressed: () => {},
                      validator: FormValidator.validatePassword,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    child: CustomButtons(
                      btnName: "Register",
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      bgColor: Colors.red,
                      handleClick: () async {
                        if (username.text.isNotEmpty &&
                            email.text.isNotEmpty &&
                            password.text.isNotEmpty &&
                            confirmPassword.text.isNotEmpty &&
                            password.text == confirmPassword.text) {
                          try {
                            final response = await createUser(
                                username.text, email.text, password.text);
                            if (response['status'] == 'success') {
                              if (!currentContext.mounted) return;
                              Navigator.pushReplacement(
                                currentContext,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            } else {}
                          } catch (error) {}
                        } else {}
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Already Registered? Login Now!',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
