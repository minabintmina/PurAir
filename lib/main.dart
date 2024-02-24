import 'package:path/path.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:purair/pages/Form.dart';
import 'package:purair/pages/Login.dart';
import 'package:purair/pages/SignUp.dart';
import 'package:purair/pages/Home.dart';
import 'package:purair/pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'classes/TranslationsDelegate.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = {
    '/Login': (context) => Login(),
    '/SignUp': (context) => SignUp(),
    '/home': (context) => Home(),
    '/Form': (context) => FormFiels(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routes: routes,
      localizationsDelegates: [
        TranslationsDelegate(), // Your custom translations delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
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
    );
  }
}