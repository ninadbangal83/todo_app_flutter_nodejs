import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/get_url.dart';

Future<Map<String, dynamic>> deleteTask(String taskId, String token) async {
  final String url = getUrl('/tasks/$taskId');
  final Map<String, String> headers = {
    'Authorization': 'Bearer $token',
  };

  try {
    // Send DELETE request to delete task
    final response = await http.delete(Uri.parse(url), headers: headers);

    // Parse and return the response body
    return json.decode(response.body);
  } catch (error) {
    // If an error occurs, throw it
    throw Exception('Failed to delete task: $error');
  }
}
