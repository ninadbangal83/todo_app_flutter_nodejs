import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/get_url.dart';

Future<dynamic> deleteUser(String token) async {
  final String url = getUrl('/user/me'); //  // Endpoint for deleting user

  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        // Include token in the request headers
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to delete user');
    }
  } catch (error) {
    return error;
  }
}
