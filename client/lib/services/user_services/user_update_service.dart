import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/get_url.dart';

Future<dynamic> updateUser(Map<String, dynamic> data, String token) async {
  final String url = getUrl('/user/me'); // Endpoint for login
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  try {
    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // Handle error response
      return response.body;
    }
  } catch (error) {
    // Handle network errors
    return error.toString();
  }
}
