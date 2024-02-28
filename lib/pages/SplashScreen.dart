import 'dart:async';

import 'package:flutter/material.dart';
import 'package:purair/pages/Terms.dart';
import 'package:purair/pages/language_selection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      final prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('authToken');
      if (authToken != null) {
        // If authToken is available, navigate to HomePage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        // If authToken is not available, navigate to LanguageSelection
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LanguageSelection()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'images/logo.gif',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}