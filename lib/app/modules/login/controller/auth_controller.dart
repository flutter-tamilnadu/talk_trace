import 'package:get/get.dart';

import '../../../utils/snackbar.dart';
import '../../../utils/storage.dart';
import '../../../utils/validators.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final email = ''.obs;
  final password = ''.obs;

  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;

  Future<void> login() async {
    try {
      // Validate inputs
      final emailError = Validators.validateEmail(email.value);
      final passwordError = Validators.validatePassword(password.value);

      // if (emailError != null || passwordError != null) {
      //   throw Exception('Please fill all fields correctly');
      // }

      isLoading.value = true;

      // Simulate API call delay
      await Future.delayed(Duration(seconds:2));

      // Check credentials (in real app, this would be an API call)
      // if (email.value == 'admin@example.com' && password.value == 'password123') {
        // Save user session
        Storage.write('is_logged_in', true);
        Storage.write('user_email', email.value);

        // Navigate to dashboard
        Get.offAllNamed('/dashboard');
        AppSnackbar.success('Login successful');
      // } else {
      //   throw Exception('Invalid email or password');
      // }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkAuthStatus() async {
    final isLoggedIn = Storage.read<bool>('is_logged_in') ?? false;
    if (isLoggedIn) {
      Get.offAllNamed('/dashboard');
    }
  }
}