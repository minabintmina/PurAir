
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:purair/pages/Home.dart';
import 'package:purair/pages/MultiPageForm.dart';
import 'package:purair/pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:purair/pages/Terms.dart';
import 'package:purair/pages/language_selection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'classes/TranslationsDelegate.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String? authToken = prefs.getString('authToken');
  runApp(MyApp(authToken: authToken));
}

class MyApp extends StatelessWidget {
  final String? authToken;

  MyApp({required this.authToken});
  final routes = {
    '/Home' : (context) => Home(),
    '/MultiPageForm' : (context) =>MultiPageForm(),
    '/LanguageSelection' : (context) => LanguageSelection(),
    '/Terms' : (context) => TermsPage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routes: routes,
      localizationsDelegates: const [
        TranslationsDelegate(), // Your custom translations delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale!.languageCode &&
              supportedLocaleLanguage.countryCode == locale.countryCode) {
            return supportedLocaleLanguage;
          }
        }
        return supportedLocales.first;
      },
      home: SplashScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/MultiPageForm') {
          return MaterialPageRoute(
            builder: (context) => MultiPageForm(),
          );
        }
        return null;
      },
    );
  }
}