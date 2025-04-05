import 'dart:convert';
import 'dart:io';

import 'package:escapenow/components/custom_button.dart';
import 'package:escapenow/components/custom_text.dart';
import 'package:escapenow/helpers/enum_helper.dart';
import 'package:escapenow/helpers/main_user.dart';
import 'package:escapenow/helpers/validator_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:escapenow/controllers/profile/profile_controller.dart';
import 'package:escapenow/helpers/catch_storage.dart';
import 'package:escapenow/helpers/constants.dart';
import 'package:escapenow/models/user_model.dart';
import 'package:escapenow/network/firestorage_service.dart';
import 'package:escapenow/network/firestore_service.dart';

class EditAccountController extends GetxController {
  UserModel model = MainUser.instance.model!;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  File? image;
  String? imagePath;

  late TextEditingController name;
  late TextEditingController location;
  late TextEditingController address;
  late TextEditingController phoneNumbner;

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController(text: model.name);
    location = TextEditingController(text: model.location);
    address = TextEditingController(text: model.address);
    phoneNumbner = TextEditingController(text: model.phoneNumber.toString());
  }

  Future<void> showImagePickerDialog() async {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: CustomText(
          text: "Choosing picture from :".tr,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: "Gallery".tr,
              onPressed: () async {
                await pickImage(ImageSource.gallery);
                Get.back(); // Close the dialog
              },
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: "Camera".tr,
              onPressed: () async {
                await pickImage(ImageSource.camera);
                Get.back(); // Close the dialog
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    var picker = await ImagePicker().pickImage(source: source);
    if (picker != null) {
      imagePath = picker.path;
      image = File(picker.path);
      await uploadImage(); // Wait for the image to be uploaded
      update(); // Update the UI after selecting and processing the image
    }
  }

  Future<String?> uploadImage() async {
    if (image == null) return null;
    String url = await FireStorageService.instance.uploadImage(image!);
    return url;
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    update();

    try {
      String? imageUrl;
      if (image != null) imageUrl = await uploadImage();

      UserModel model = UserModel(
        uId: model.uId,
        email: model.email,
        address: address.text,
        name: name.text,
        location: location.text,
        phoneNumber: int.parse(phoneNumbner.text),
        image: imageUrl ?? model.image,
      );

      await FirestoreServic.instance.updateUser(model);

      await CatchStorage.save(k_userKey, jsonEncode(model.toMap));

      MainUser.instance.update();

      Get.back();

      Get.find<ProfileController>().update();

      isLoading = false;
      update();
    } on FirebaseException catch (error) {
      Get.snackbar(
        "Something_wrong".tr,
        error.message!,
        backgroundColor: Colors.red,
      );
      isLoading = false;
      update();
    }
  }

  String? validateField(String? value, FieldType type) {
    return ValidatorHelper.instance.validator(value: value, type: type);
  }
}
