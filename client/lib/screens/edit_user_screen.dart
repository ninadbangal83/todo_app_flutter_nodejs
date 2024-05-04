import 'package:flutter/material.dart';
import 'package:todo_app_flutter_nodejs/providers/user_provider.dart';
import '../utils/update_user_handler.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final username = TextEditingController();

  final email = TextEditingController();

  bool taskStatus = false;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    // Check if user is not null before initializing the controllers
    if (user != null) {
      username.text = user.username;
      email.text = user.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        label: "Username",
                        enabled: true,
                        value: username,
                        focusedBorderColor: Colors.blue,
                        enabledBorderColor: Colors.blue,
                        disabledBorderColor: Colors.blue,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: CustomTextField(
                        label: "Email",
                        enabled: true,
                        value: email,
                        focusedBorderColor: Colors.blue,
                        enabledBorderColor: Colors.blue,
                        disabledBorderColor: Colors.blue,
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
                        handleClick: () {
                          final user = {
                            "name": username.text,
                            "email": email.text,
                          };
                          updateUserHandler(currentContext, user);
                        },
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
