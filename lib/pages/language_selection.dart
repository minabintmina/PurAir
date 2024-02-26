import 'package:flutter/material.dart';

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
                _setLanguageAndNavigate(context, 'en'); // Frensh
              },
              child: Text('Frensh'),
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

  void _setLanguageAndNavigate(BuildContext context, String languageCode) {
    // Save selected language here if needed
    print("Selected language code: $languageCode");
    Navigator.pushReplacementNamed(context, '/MultiForm', arguments: languageCode);
  }
}
