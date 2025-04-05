import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:escapenow/components/custom_button.dart';
import 'package:escapenow/components/custom_field.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:escapenow/controllers/profile/verify_phone_controller.dart';

class ChangePhoneNumberDialog extends GetWidget<VerifyPhoneController> {
  ChangePhoneNumberDialog({Key? key}) : super(key: key);
  final VerifyPhoneController verifyPhoneController =
      Get.put(VerifyPhoneController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Change Phone Number".tr,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomField(
                    hint: "Country Code".tr,
                    controller: controller.countryCodeController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: CustomField(
                    hint: "New Phone Number".tr,
                    controller: controller.newPhoneNumberController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Send Verification Code".tr,
              onPressed: () {
                controller.verifyNewPhoneNumber();
              },
            ),
            const SizedBox(height: 20),
            CustomField(
              hint: "Verification Code".tr,
              controller: controller.verificationCodeController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Verify".tr,
              onPressed: () {
                controller.verifyPhoneNumber();
              },
            ),
          ],
        ),
      ),
    );
  }
}
