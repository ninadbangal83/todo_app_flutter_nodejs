import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/get_url.dart';

Future loginUser(String email, String password) async {
  final String url = getUrl('/user/login'); // Endpoint for login

  try {
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', responseData["token"]);
      return responseData;
    } else {
      return response.body;
    }
  } catch (error) {
    return error;
  }
}
