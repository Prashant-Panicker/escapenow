import 'package:escapenow/components/phone_change_dialog.dart';
import 'package:escapenow/helpers/enum_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:escapenow/components/build_image.dart';
import 'package:escapenow/components/custom_button.dart';
import 'package:escapenow/components/custom_field.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:escapenow/controllers/profile/edit_account_controller.dart';

class EditAccountScreen extends GetWidget<EditAccountController> {
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Edit Account".tr,
          fontSize: 20,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      controller.showImagePickerDialog();
                    },
                    child: Stack(
                      children: [
                        BuildImage(
                          image:
                              controller.imagePath ?? controller.model.image!,
                          width: 120,
                          height: 120,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomText(
                        text: "Name".tr,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomField(
                        hint: "Name".tr,
                        controller: controller.name,
                        validator: (value) =>
                            controller.validateField(value, FieldType.name),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomText(
                        text: "Location".tr,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomField(
                        hint: "Location".tr,
                        controller: controller.location,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomText(
                        text: "Address".tr,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomField(
                        hint: "Address".tr,
                        controller: controller.address,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomText(
                        text: "Phone Number".tr,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          CustomButton(
                            width: 200,
                            text: "Change",
                            onPressed: () {
                              Get.dialog(ChangePhoneNumberDialog());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  child: CustomButton(
                    text: "Save Changes".tr,
                    onPressed: controller.isLoading
                        ? null
                        : () => controller.onSubmit(),
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
