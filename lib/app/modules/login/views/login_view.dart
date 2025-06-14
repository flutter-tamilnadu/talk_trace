import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/validators.dart';
import '../../../widgets/app_button.dart';
import '../controller/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: Get.height * 0.1),
                FlutterLogo(size: 120),
                SizedBox(height: 32),
                Text(
                  'Welcome Back',
                  style: Get.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Sign in to continue',
                  style: Get.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => Validators.validateEmail(value),
                  onChanged: controller.setEmail,
                ),
                SizedBox(height: 16),
                Obx(() => TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.password.value.isEmpty
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        // Toggle password visibility
                      },
                    ),
                  ),
                  obscureText: true,
                  validator: (value) => Validators.validatePassword(value),
                  onChanged: controller.setPassword,
                )),
                SizedBox(height: 24),
                Obx(() => AppButton(
                  text: 'Login',
                  onPressed: controller.login,
                  isLoading: controller.isLoading.value,
                )),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    AppSnackbar.info('Forgot password clicked');
                  },
                  child: Text('Forgot Password?'),
                ),
                SizedBox(height: Get.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}