import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login_screen.dart';
import '../services/user_services/user_delete_service.dart';
import '../services/user_services/user_logout_service.dart';

logoutDeleteHandler(currentContext, action) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');

  if (accessToken != null) {
    try {
      dynamic response;
      if (action == "logout") {
        response = await logoutUser(accessToken!);
      } else {
        response = await deleteUser(accessToken!);
      }

      if (response['status'] == 'success') {
        await prefs.remove('accessToken');
        if (!currentContext.mounted) return;
        Navigator.of(currentContext).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (currentContext) => const LoginScreen(),
            settings: const RouteSettings(name: '/login'),
            // Optional: set route name
            fullscreenDialog: true, // Optional: use a fullscreen dialog
          ),
          (route) => false, // Pop all existing routes
        );
      } else {
        // Handle login failure
      }
    } catch (error) {
      // Handle error
    }
  }
}
