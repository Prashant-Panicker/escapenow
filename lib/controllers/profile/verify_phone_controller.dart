import 'package:escapenow/controllers/profile/edit_account_controller.dart';
import 'package:escapenow/network/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPhoneController extends GetxController {
  final newPhoneNumberController = TextEditingController();
  final verificationCodeController = TextEditingController();
  final countryCodeController = TextEditingController();
  final AuthService authService = AuthService.instance;

  Future<void> verifyNewPhoneNumber() async {
    final countryCode = countryCodeController.text.trim();
    final newPhoneNumber = newPhoneNumberController.text.trim();

    if (countryCode.isEmpty || newPhoneNumber.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a valid country code and phone number",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }

    final fullPhoneNumber = "$countryCode$newPhoneNumber";

    try {
      await authService.sendPhoneVerificationCode(fullPhoneNumber);
      print(fullPhoneNumber);
      Get.snackbar(
        "Success",
        "Verification code sent to $fullPhoneNumber",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to send verification code: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> verifyPhoneNumber() async {
    final verificationCode = verificationCodeController.text.trim();

    if (verificationCode.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter the verification code",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      await authService.signInWithPhoneCredential(verificationCode);
      print(verificationCode);

      Get.snackbar(
        "Success",
        "Phone number verified successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );

      // Update the phone number in the EditAccountController
      Get.find<EditAccountController>().phoneNumbner.text =
          newPhoneNumberController.text.trim();
      print(Get.find<EditAccountController>().phoneNumbner.text);
      Get.back(); // Close the dialog
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to verify phone number: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
}
