import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:escapenow/components/custom_button.dart';
import 'package:escapenow/components/custom_field.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:escapenow/controllers/auth/login_controller.dart';
import 'package:escapenow/helpers/constants.dart';
import 'package:escapenow/views/auth/register_screen.dart';
import 'package:escapenow/views/auth/rest_password_screen.dart';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                CustomText(
                  text: "login".tr,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 30),
                CustomField(
                  hint: "enter_email".tr,
                  controller: controller.email,
                ),
                const SizedBox(height: 25),
                CustomField(
                  hint: "password".tr,
                  suffixIcon: const LineIcon.lowVision(),
                  obscureText: true,
                  controller: controller.password,
                ),
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const RestPasswordScreen());
                    },
                    child: CustomText(
                      text: "forget_password?".tr,
                      color: k_primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                GetBuilder<LoginController>(builder: (controller) {
                  return CustomButton(
                    width: Get.width,
                    text: "login_button".tr,
                    onPressed: controller.isLoading
                        ? null
                        : () {
                            controller.login();
                          },
                  );
                }),
                const SizedBox(height: 50),
                Center(
                  child: CustomText(
                    text: "not_have_account".tr,
                    fontSize: 14,
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.off(() => const RegisterScreen());
                    },
                    child: Column(
                      children: [
                        CustomText(
                          text: "register_button".tr.toUpperCase(),
                          color: k_primaryColor,
                          fontSize: 14,
                          letterSpacing: 2,
                        ),
                        const SizedBox(height: 2),
                        Container(
                          width: 35,
                          height: 1.5,
                          color: k_primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
