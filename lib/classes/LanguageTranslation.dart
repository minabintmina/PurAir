import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class LanguageTranslation {
  late Locale locale;
  static late Map<dynamic, dynamic> _localizedValues;

  LanguageTranslation(this.locale);

  static Future<LanguageTranslation> load(Locale locale) async {
    LanguageTranslation translations = LanguageTranslation(locale);
    String jsonContent =
    await rootBundle.loadString("assets/trans/${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  static LanguageTranslation? of(BuildContext context) {
    return Localizations.of<LanguageTranslation>(context, LanguageTranslation);
  }

  String value(String key) {
    return _localizedValues[key] ?? 'loading';
  }

  String get currentLanguage => locale.languageCode;
}
