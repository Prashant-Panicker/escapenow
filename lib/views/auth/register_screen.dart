import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:escapenow/components/custom_button.dart';
import 'package:escapenow/components/custom_field.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:get/get.dart';
import 'package:escapenow/controllers/auth/register_controller.dart';
import 'package:escapenow/helpers/constants.dart';
import 'package:escapenow/helpers/enum_helper.dart';
import 'package:escapenow/helpers/validator_helper.dart';
import 'package:escapenow/views/auth/login_screen.dart';

class RegisterScreen extends GetWidget<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  CustomText(
                    text: "register".tr,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 30),
                  CustomField(
                    hint: "full_name".tr,
                    controller: controller.name,
                    validator: (value) {
                      return ValidatorHelper.instance.validator(
                        value: controller.name.text,
                        type: FieldType.name,
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomField(
                    hint: "enter_email".tr,
                    controller: controller.email,
                    validator: (value) {
                      return ValidatorHelper.instance.validator(
                        value: controller.email.text,
                        type: FieldType.email,
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomField(
                    hint: "password".tr,
                    suffixIcon: const LineIcon.lowVision(),
                    obscureText: true,
                    controller: controller.password,
                    validator: (value) {
                      return ValidatorHelper.instance.validator(
                        value: controller.password.text,
                        type: FieldType.password,
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomField(
                    hint: "confirm_password".tr,
                    suffixIcon: const LineIcon.lowVision(),
                    controller: controller.confirmPassword,
                    obscureText: true,
                    validator: (value) {
                      return ValidatorHelper.instance.validator(
                        value: controller.confirmPassword.text,
                        matchText: controller.password.text,
                        type: FieldType.confirmPassword,
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  GetBuilder<RegisterController>(builder: (controller) {
                    return CustomButton(
                      width: Get.width,
                      text: "register".tr,
                      onPressed: controller.isLoading
                          ? null
                          : () async {
                              await controller.createAccount();
                            },
                    );
                  }),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "have_account".tr,
                          fontSize: 14,
                        ),
                        const SizedBox(
                            width:
                                8), // Add some spacing between the text and the button
                        TextButton(
                          onPressed: () async {
                            await Get.off(() => const LoginScreen());
                            Get.find<RegisterController>().onClose();
                          },
                          child: Column(
                            children: [
                              CustomText(
                                text: "login_button".tr.toUpperCase(),
                                color: k_primaryColor,
                                fontSize: 14,
                                letterSpacing: 2,
                              ),
                              const SizedBox(height: 2),
                              Container(
                                width: 30,
                                height: 1.5,
                                color: k_primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
