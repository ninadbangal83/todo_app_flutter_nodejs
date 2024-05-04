import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/get_url.dart';

Future createUser(String username, String email, String password) async {
  final String url = getUrl('/user');

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body:
          jsonEncode({'name': username, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      return responseData;
    } else if (response.statusCode == 400) {
      return response.body;
    } else {
      return response.body;
    }
  } catch (error) {
    return error;
  }
}
