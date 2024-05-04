import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home_screen.dart';
import '../services/user_services/user_update_service.dart';

updateUserHandler(currentContext, user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');

  if (accessToken != null) {
    try {
      final response = await updateUser(user, accessToken);

      if (response['status'] == 'success') {
        if (!currentContext.mounted) return;
        Navigator.pushReplacement(
          currentContext,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // Handle login failure
      }
    } catch (error) {
      // Handle error
    }
  }
}
