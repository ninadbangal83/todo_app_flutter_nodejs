import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home_screen.dart';
import '../services/task_services/create_task_service.dart';
import '../services/task_services/update_task_service.dart';

createEditTaskHandler(currentContext, title, task, taskId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');
  print(accessToken);
  print("object $title");

  if (accessToken != null) {
    dynamic response;
    try {
      if (title == "Create") {
        response = await createTask(task, accessToken);
      } else {
        response = await updateTask(taskId, task, accessToken);
      }

      print(response);
      if (response['status'] == 'success') {
        if (!currentContext.mounted) return;
        if (title != "bool") {
          Navigator.pushReplacement(
            currentContext,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        // Handle login failure
      }
    } catch (error) {
      // Handle error
    }
  }
}