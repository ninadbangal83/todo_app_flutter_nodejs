import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/get_url.dart';

Future<Object> getUser(String token) async {
  final String url = getUrl(
      '/user/me'); // / Endpoint for login // Replace with your API endpoint
  final Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      return userData;
    } else {
      throw Exception('Failed to load user data');
    }
  } catch (error) {
    return error;
  }
}
