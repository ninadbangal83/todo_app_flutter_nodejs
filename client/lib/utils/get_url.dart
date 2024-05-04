import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:todo_app_flutter_nodejs/utils/constants.dart';

String getUrl(String endpoint) {
  if (kIsWeb) {
    // For Android
    return '${Constants.webBaseUrl}$endpoint'; // Assuming server is running on localhost
  } else if (Platform.isIOS ||
      Platform.isMacOS ||
      Platform.isWindows ||
      Platform.isLinux) {
    // For other platforms
    return '${Constants.webBaseUrl}$endpoint';
  } else {
    // For other platforms
    return '${Constants.androidBaseUrl}$endpoint';
  }
}
