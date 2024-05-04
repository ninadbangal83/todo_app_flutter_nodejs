import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/get_url.dart';

Future logoutUser(String token) async {
  final String url = getUrl('/user/logout'); // / Endpoint for logout

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        // Include token in the request headers
      },
      body: json.encode({}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to logout');
    }
  } catch (error) {
    return error;
  }
}
