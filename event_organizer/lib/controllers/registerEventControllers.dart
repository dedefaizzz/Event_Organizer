import 'package:flutter/material.dart';
import 'package:get/get.dart';

class registerEventController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController institutionController = TextEditingController();

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateInstitution(String value) {
    if (value.isEmpty) {
      return 'Institution is required';
    }
    return null;
  }

  Future<void> registerEvent() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final institution = institutionController.text.trim();

    if (validateName(name) != null ||
        validateEmail(email) != null ||
        validatePassword(password) != null ||
        validateInstitution(institution) != null) {
      Get.snackbar('Error', 'Please fill all fields correctly');
      return;
    }

    try {
      await Future.delayed(Duration(seconds: 2));

      nameController.clear();
      emailController.clear();
      passwordController.clear();
      institutionController.clear();

      Get.snackbar('Success', 'Event registered successfully');
    } catch (error) {
      Get.snackbar(
          'Error', 'Failed to register the event. Please try again later');
    }
  }
}
