import 'package:get/get.dart';

class Logger {
  static void info(String message) {
    Get.log(message, isError: false);
  }

  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    Get.log('Error: $message', isError: true);
    if (error != null) {
      Get.log('Error details: $error', isError: true);
    }
    if (stackTrace != null) {
      Get.log('Stack trace: $stackTrace', isError: true);
    }
  }

  static void debug(String message) {
    // Only print in debug mode
    assert(() {
      Get.log('[DEBUG] $message', isError: false);
      return true;
    }());
  }
}