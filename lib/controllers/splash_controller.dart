import 'package:get/get.dart';
import 'package:escapenow/helpers/catch_storage.dart';
import 'package:escapenow/helpers/constants.dart';
import 'package:escapenow/views/auth/login_screen.dart';
import 'package:escapenow/views/layout/layout_screen.dart';
import 'package:escapenow/views/on_boarding/on_boarding_screen.dart';
import 'package:escapenow/views/splash/choose_language_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    await Future.delayed(const Duration(seconds: 2));
    if (CatchStorage.get(k_langKey) == null) {
      await Get.off(() => const ChooseLanguageScreen());
      return;
    }
    if (CatchStorage.get(k_onBoardingKey) == null &&
        CatchStorage.get(k_onBoardingKey) == false) {
      await Get.off(() => const OnBoardingScreen());
      return;
    }
    if (CatchStorage.get(k_userKey) == null) {
      await Get.off(() => const LoginScreen());
      return;
    }
    if (CatchStorage.get(k_userKey) != null) {
      await Get.off(() => const LayoutScreen());
      // await Get.off(() => HomeScreen());
      return;
    }
  }
}
