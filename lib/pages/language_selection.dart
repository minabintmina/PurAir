import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/LanguageTranslation.dart';

class LanguageSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Language'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _setLanguageAndNavigate(context, 'en'); // English
              },
              child: Text('English'),
            ),
            ElevatedButton(
              onPressed: () {
                _setLanguageAndNavigate(context, 'ar'); // Arabic
              },
              child: Text('العربية'),
            ),
          ],
        ),
      ),
    );
  }

  void _setLanguageAndNavigate(BuildContext context, String languageCode) async {
    // Save selected language here if needed
    print("Selected language code: $languageCode");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    Locale selectedLocale = Locale(languageCode);
    await LanguageTranslation.load(selectedLocale);
    Navigator.pushReplacementNamed(context, '/MultiForm');
  }
}
