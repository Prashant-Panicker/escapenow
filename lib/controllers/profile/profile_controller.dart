import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:escapenow/helpers/catch_storage.dart';
import 'package:escapenow/helpers/constants.dart';
import 'package:escapenow/views/auth/login_screen.dart';

class ProfileController extends GetxController {
  Future<void> logut() async {
    FirebaseAuth.instance.signOut();
    await CatchStorage.remove(k_userKey);
    Get.off(() => const LoginScreen());
  }
}
