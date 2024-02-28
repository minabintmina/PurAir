import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/LanguageTranslation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _languageCode = ''; // Language code fetched from Firestore

  @override
  void initState() {
    super.initState();
    fetchLanguageFromSharedPreferences();
    // Fetch language code when the widget initializes
  }

  Future<String?> fetchLanguageFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString('language')!;
    return _languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LanguageTranslation.of(context)!.value('Nom'),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        shadowColor: Colors.purple,
        leading: IconButton( // Add leading property for back button
          icon: Icon(Icons.arrow_back), // Use back arrow icon
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/LanguageSelection', (route) => false); // Pop the current route to go back
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Text("home"),
      ),
    );
  }
}
