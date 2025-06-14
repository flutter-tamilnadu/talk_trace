import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static void success(String message, {String title = 'Success'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green.withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }

  static void error(String message, {String title = 'Error'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red.withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }

  static void info(String message, {String title = 'Info'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.blue.withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }
}