import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/get_url.dart';

const String baseUrl = 'http://10.0.2.2:4000'; // Replace with your API base URL

Future<Map<String, dynamic>> updateTask(
    String taskId, Map<String, dynamic> taskData, String token) async {
  final String url = getUrl(
      '/tasks/$taskId'); // Endpoint for updateTask // Replace with your API endpoint
  final Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  try {
    // Encode task data to JSON
    String body = jsonEncode(taskData);

    // Send PATCH request to update task
    final response =
        await http.patch(Uri.parse(url), headers: headers, body: body);

    // Check if request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse and return the response body
      return json.decode(response.body);
    } else {
      // Request failed, throw an exception
      throw Exception('Failed to update task: ${response.body}');
    }
  } catch (error) {
    // Catch any errors and throw them
    throw Exception('Failed to update task: $error');
  }
}
