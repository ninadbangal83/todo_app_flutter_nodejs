import 'package:flutter/material.dart';
import 'package:todo_app_flutter_nodejs/screens/home_screen.dart';
import 'package:todo_app_flutter_nodejs/screens/register_screen.dart';
import 'package:todo_app_flutter_nodejs/widgets/custom_buttons.dart';
import 'package:todo_app_flutter_nodejs/widgets/custom_text_field.dart';

import '../services/user_services/user_login_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();

  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.blue,
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
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: CustomTextField(
                      label: "Email",
                      enabled: true,
                      value: email,
                      suffixIcon: Icons.email,
                      focusedBorderColor: Colors.blue,
                      enabledBorderColor: Colors.blue,
                      disabledBorderColor: Colors.blue,
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
                      focusedBorderColor: Colors.blue,
                      enabledBorderColor: Colors.blue,
                      disabledBorderColor: Colors.blue,
                      handleSuffixOnPressed: () {},
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    child: CustomButtons(
                      btnName: "Login",
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      bgColor: Colors.blue,
                      handleClick: () async {
                        try {
                          final response =
                              await loginUser(email.text, password.text);
                          if (response['status'] == 'success') {
                            if (!currentContext.mounted) return;
                            Navigator.pushReplacement(
                              currentContext,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          } else {
                            // Handle login failure
                          }
                        } catch (error) {
                          // Handle error
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text(
                      'New user? Register Now!',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      },
                      child: const Text(
                        'Join as a guest!',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
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
