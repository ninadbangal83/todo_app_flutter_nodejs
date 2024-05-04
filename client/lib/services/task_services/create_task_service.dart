import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/get_url.dart';

Future<Map<String, dynamic>> createTask(
    Map<String, dynamic> taskData, String token) async {
  final String url = getUrl('/tasks');

  /// Endpoint for createTask // Replace with your API endpoint
  final Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(taskData));

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to create task: ${response.body}');
    }
  } catch (error) {
    throw Exception('Failed to create task: $error');
  }
}
