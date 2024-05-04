import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getAccessToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken');
}

Future<bool> isLoggedIn() async {
  final accessToken = await getAccessToken();
  return accessToken !=
      null; // Return true if access token exists, indicating the user is logged in
}