import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:escapenow/controllers/home/home_controller.dart';
import 'package:escapenow/controllers/profile/profile_controller.dart';
import 'package:escapenow/helpers/catch_storage.dart';
import 'package:escapenow/helpers/constants.dart';

class _LanguageModel {
  final String IsoCode;
  final String language;
  _LanguageModel({
    required this.IsoCode,
    required this.language,
  });
}

class ChangeLanguageController extends GetxController {
  List<_LanguageModel> languages = [
    _LanguageModel(IsoCode: "en", language: "English"),
    _LanguageModel(IsoCode: "ml", language: "മലയാളം"),
  ];

  String language = CatchStorage.get(k_langKey) ?? "en";

  late int languageIndexSelected;

  @override
  onInit() {
    super.onInit();
    languageIndexSelected =
        languages.indexWhere((element) => element.IsoCode == language);
  }

  void onChange(int newIndex) {
    languageIndexSelected = newIndex;
    update();
  }

  Future<void> updateLocal() async {
    var selectedLanguage = languages[languageIndexSelected];
    await CatchStorage.save(k_langKey, selectedLanguage.IsoCode);
    await Get.updateLocale(Locale(selectedLanguage.IsoCode));
    // update();
    Get.find<ProfileController>().onInit();
    Get.find<HomeController>().onInit();
    Get.back();
  }
}
