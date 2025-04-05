import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:escapenow/helpers/binding.dart';
import 'package:escapenow/helpers/constants.dart';
import 'package:escapenow/helpers/main_user.dart';
import 'package:escapenow/multi_language/langeuages/translations.dart';
import 'package:escapenow/helpers/catch_storage.dart';
import 'package:escapenow/views/splash/splash_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  MainUser.instance.onInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  String _getLanguage() {
    String lang = CatchStorage.get(k_langKey) ?? "en";
    return lang;
  }

  String? _getFont() {
    if (_getLanguage() == "en") {
      return GoogleFonts.poppins().fontFamily;
    }
    if (_getLanguage() == "ml") {
      return GoogleFonts.tajawal().fontFamily;
    }
    return GoogleFonts.poppins().fontFamily;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EscapeNow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        canvasColor: k_canvas,
        primarySwatch: k_primaryColor,
        fontFamily: _getFont(),
      ),
      // locale: Locale("ml"),
      locale: Locale(_getLanguage()),
      fallbackLocale: const Locale("en"),
      translations: Translation(),
      initialBinding: Binding(),
      home: const SplashScreen(),
    );
  }
}
