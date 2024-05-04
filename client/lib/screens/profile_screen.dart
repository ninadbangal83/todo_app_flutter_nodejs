import 'package:flutter/material.dart';

import '../utils/logout_delete_user_handler.dart';
import '../widgets/custom_list_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: MediaQuery.of(context).size.width > 600
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomListWidget(
          currentContext: currentContext,
          logoutAction: () => logoutDeleteHandler(currentContext, "logout"),
          deleteAccountAction:
              () => logoutDeleteHandler(currentContext, "delete"),
        ),
      )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomListWidget(
                currentContext: currentContext,
                logoutAction: () => logoutDeleteHandler(currentContext, "logout"),
                deleteAccountAction:
                    () => logoutDeleteHandler(currentContext, "delete"),
              ),
            ),
    );
  }
}
