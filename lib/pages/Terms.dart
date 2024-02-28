import 'package:flutter/material.dart';

import '../classes/LanguageTranslation.dart';

class TermsPage extends StatefulWidget {
  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool _isChecked = false;
  late bool _isEnglish;

  @override
  void initState() {
    super.initState();
    _isEnglish=true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Center(
            child: Text(
              LanguageTranslation.of(context)!.value('Terms'),
              style: TextStyle(
                fontFamily: LanguageTranslation.of(context)!.value('Font'),
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
          ),
          backgroundColor: Colors.green,
          elevation: 5,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LanguageTranslation.of(context)!.value('TermsTitle'),
                    style: TextStyle(
                      fontFamily: LanguageTranslation.of(context)!.value('Font'),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    LanguageTranslation.of(context)!.value('TermsConditions'),
                    style: TextStyle(
                      fontFamily: LanguageTranslation.of(context)!.value('Font'),
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                        activeColor: Colors.green, // Change color of checked checkbox to green
                      ),
                      Expanded(
                        child: Text(
                          LanguageTranslation.of(context)!.value('TermsCheckbox'),
                          style: TextStyle(
                            fontFamily: LanguageTranslation.of(context)!.value('Font'),
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.green, width: 2.0),
                  ),
                  minimumSize: Size(200, 50),
                ),
                onPressed: _isChecked
                    ? () {
                  Navigator.pushReplacementNamed(context, '/MultiPageForm');
                }
                    : null,
                child: Text(
                  LanguageTranslation.of(context)!.value('TermsButton'),
                  style: TextStyle(
                      fontFamily: LanguageTranslation.of(context)!.value('Font'),
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
