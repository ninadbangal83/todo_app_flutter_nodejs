import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/get_url.dart';

Future<List<dynamic>> getTasks(String token) async {
  final String url = getUrl(
      '/tasks'); // Endpoint for getTasks // Replace with your API endpoint
  final Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> tasks = json.decode(response.body);
      return tasks;
    } else {
      throw Exception('Failed to get tasks: ${response.body}');
    }
  } catch (error) {
    throw Exception('Failed to get tasks: $error');
  }
}
