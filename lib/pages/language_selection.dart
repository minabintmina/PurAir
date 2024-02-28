import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/LanguageTranslation.dart';

class LanguageSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
    child: AppBar(
        backgroundColor: Colors.green,
        elevation: 5, // Adding elevation to create shadow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Langage',
              style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 22, // Making the title bigger
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(2, 2), // Adding shadow offset
                    blurRadius: 3, // Adding shadow blur radius
                    color: Colors.black.withOpacity(0.5), // Shadow color
                  ),
                ],
              ),
            ),
            Text(
              'لغة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 22, // Making the title bigger
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(2, 2), // Adding shadow offset
                    blurRadius: 3, // Adding shadow blur radius
                    color: Colors.black.withOpacity(0.5), // Shadow color
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Text(
              'Choisissez votre langue préférée',
              style: TextStyle(
                fontSize: 20, // Increase font size
                color: Colors.black,
                fontFamily: 'RobotoCondensed',// Set text color to black
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0, 2), // Adding shadow offset
                    blurRadius: 3, // Adding shadow blur radius
                    color: Colors.black.withOpacity(0.5), // Shadow color
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'اختر لغتك المفضلة',
              style: TextStyle(
                fontSize: 20, // Increase font size
                color: Colors.black,
                fontFamily: 'Cairo',// Set text color to black
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0, 2), // Adding shadow offset
                    blurRadius: 3, // Adding shadow blur radius
                    color: Colors.black.withOpacity(0.5), // Shadow color
                  ),
                ],
              ),
            ),

            SizedBox(height: 100),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.green, width: 2.0),
                ),
                minimumSize: Size(250, 60),
              ),
              onPressed: () {
                _setLanguageAndNavigate(context, 'en'); // English
              },
              child: Text(
                'Français',
                style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.green, width: 2.0),
                ),
                minimumSize: Size(250, 60),
              ),
              onPressed: () {
                _setLanguageAndNavigate(context, 'ar'); // Arabic
              },
              child: Text(
                'العربية',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 20,
                    color: Colors.black),
              ),
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
    Navigator.pushReplacementNamed(context, '/Terms');
  }
}
