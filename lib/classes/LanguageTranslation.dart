import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class LanguageTranslation {
  late Locale locale;
  static Map<dynamic, dynamic> _localizedValues = new Map();

  LanguageTranslation(Locale locale) {
    this.locale = locale;
    _localizedValues = new Map();
  }

  static LanguageTranslation? of(BuildContext context) {
    return Localizations.of<LanguageTranslation>(context, LanguageTranslation);
  }

  String value(String key) {
    return _localizedValues[key] ?? 'loading';
  }

  static Future<LanguageTranslation> load(Locale locale) async {
    LanguageTranslation translations = LanguageTranslation(locale);
    String jsonContent =
        await rootBundle.loadString("assets/trans/${locale.languageCode}.json");
    print(jsonContent);
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;
}
