import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../services/task_services/get_task_service.dart';

class TaskProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _tasks = []; // List to store tasks

  // Method to fetch tasks
  Future<void> fetchTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    try {
      final tasksFromApi = await getTasks(accessToken!);

      _tasks = tasksFromApi.cast<Map<String, dynamic>>();

      notifyListeners();
    } catch (error) {
      // Handle error
      print('Error fetching tasks: $error');
    }
  }

  Future<void> deleteTask(String taskId) async {
    // Your deletion logic
    _tasks.removeWhere((task) => task['_id'] == taskId);

    // Update task numbers after deletion
    for (int i = 0; i < _tasks.length; i++) {
      _tasks[i]['taskNumber'] = i + 1;
    }

    notifyListeners();
  }

  // Getter to access tasks
  List<Map<String, dynamic>> get tasks => _tasks;
}

