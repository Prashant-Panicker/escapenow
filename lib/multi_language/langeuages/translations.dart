import 'package:get/get.dart';
import 'package:escapenow/multi_language/langeuages/ml.dart';
import 'package:escapenow/multi_language/langeuages/en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": en,
        "ml": ml,
      };
}
