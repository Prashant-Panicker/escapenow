import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:escapenow/components/custom_button.dart';
import 'package:escapenow/components/custom_field.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:escapenow/controllers/auth/rest_password_controller.dart';
import 'package:escapenow/helpers/enum_helper.dart';
import 'package:escapenow/helpers/validator_helper.dart';

class RestPasswordScreen extends GetWidget<RestPasswordController> {
  const RestPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  CustomText(
                    text: "forget_password".tr,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    text: "forget_password_message".tr,
                    textAlign: TextAlign.start,
                    fontSize: 17,
                  ),
                  const SizedBox(height: 30),
                  CustomField(
                    hint: "enter_email".tr,
                    controller: controller.email,
                    validator: (value) {
                      return ValidatorHelper.instance.validator(
                        value: value,
                        type: FieldType.email,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    width: Get.width,
                    text: "send".tr,
                    onPressed: () async {
                      await controller.sendPasswordResetEmail();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
