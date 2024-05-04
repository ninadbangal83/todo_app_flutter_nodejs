import 'package:flutter/material.dart';

import '../widgets/custom_buttons.dart';
import '../widgets/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Colors.blue,
      ),
      body: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                        label: "Current Password",
                        enabled: true,
                        value: currentPassword,
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
                        label: "New Password",
                        enabled: true,
                        value: newPassword,
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
                        label: "Confirm Password",
                        enabled: true,
                        value: confirmPassword,
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
                        btnName: "Save",
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.white),
                        bgColor: Colors.blue,
                        handleClick: () async {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
