import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../classes/LanguageTranslation.dart';
class FormFiels extends StatefulWidget {
  @override
  State<FormFiels> createState() => _FormFielsState();
}

class _FormFielsState extends State<FormFiels> {
  bool _isEnglish = true;
  bool numberExists = false;
  bool emailExists = false;
  void onLocaleChange(Locale locale) async {
    setState(() {
      LanguageTranslation.load(locale);
    });
  }
  TextEditingController txt_nom = new TextEditingController();

  TextEditingController txt_prenom = new TextEditingController();

  TextEditingController txt_number = new TextEditingController();

  TextEditingController txt_email = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          title: Text(LanguageTranslation.of(context)!.value('app_title')),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              icon: Icon(
                Icons.language, // Customize the icon here
                color: Colors.black, // Customize the color if needed
              ),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: Row(
                    children: [
                       Image.asset(
                        'images/fr.png', // Path to French flag image
                        width: 24, // Adjust size as needed
                        height: 24,
                      ), // Icon for language
                      SizedBox(width: 8), // Add some spacing between icon and text
                      Text('Français'), // Language name
                    ],
                  ),
                  value: 'en',
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Image.asset(
                        'images/tun.png', // Path to French flag image
                        width: 24, // Adjust size as needed
                        height: 24,
                      ),
                      SizedBox(width: 8), // Add some spacing between icon and text
                      Text('العربية'), // Language name
                    ],
                  ),
                  value: 'ar',
                ),

              ],
              onSelected: (String value) {
                setState(() {
                  // Call the function to change the locale based on the selected language
                  onLocaleChange(Locale(value));
                });
              },
            ),
          ],
        ),
      ),

      body:  Container(

            child: SingleChildScrollView(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80), // Adjust the height to move the form down
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: txt_nom,
                      cursorColor: Colors.blue,
                      textDirection: _isEnglish?TextDirection.ltr:TextDirection.rtl,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_outlined),
                        hintText: LanguageTranslation.of(context)!.value('Nom'),
                        border: InputBorder.none,
                        focusColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LanguageTranslation.of(context)!.value('NomRequired');
                        }
                        return null;
                      },
                    ),


                  ),

                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: txt_prenom,
                      textDirection: _isEnglish?TextDirection.ltr:TextDirection.rtl,
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_outlined),
                        hintText: LanguageTranslation.of(context)!.value('Prénom'),
                        border: InputBorder.none,
                        focusColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return  LanguageTranslation.of(context)!.value('PrenomRequired');
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: txt_email,

                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: LanguageTranslation.of(context)!.value('Email'),
                  border: InputBorder.none,
                  focusColor: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,

                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return LanguageTranslation.of(context)!.value('EmailRequired');
                  }
                  return null;
                },

              ),

            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: txt_number,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.numbers_outlined),
                  hintText: LanguageTranslation.of(context)!.value('Téléphone'),
                  border: InputBorder.none,
                  focusColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(8),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return LanguageTranslation.of(context)!.value('NumberRequired');
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  primary: Colors.purple[200],
                ),
                onPressed: () async {
                  // Check if any of the fields are empty
                  if (txt_nom.text.isEmpty ||
                      txt_prenom.text.isEmpty ||
                      txt_email.text.isEmpty ||
                      txt_number.text.isEmpty) {
                    // Show a Snackbar indicating that all fields are required
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            LanguageTranslation.of(context)!.value('FieldsRequired'),
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return; // Exit the function if any field is empty
                  }

                  FirebaseFirestore firestore = FirebaseFirestore.instance;

                  // Check if email already exists
                  QuerySnapshot emailSnapshot = await firestore
                      .collection('users')
                      .where('email', isEqualTo: txt_email.text)
                      .get();

                  // Check if number already exists
                  QuerySnapshot numberSnapshot = await firestore
                      .collection('users')
                      .where('number', isEqualTo: txt_number.text)
                      .get();

                  // Check if email or number already exists
                  if (emailSnapshot.docs.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          LanguageTranslation.of(context)!.value('EmailExist'),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (numberSnapshot.docs.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          LanguageTranslation.of(context)!.value('NumberExist'),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Add data to Firestore if email and number don't exist
                  firestore.collection('users').add({
                    'nom': txt_nom.text,
                    'prenom': txt_prenom.text,
                    'email': txt_email.text,
                    'number': txt_number.text,
                  }).then((value) {
                    // Data added successfully
                    print('Data added to Firestore');

                    // Navigate to the next screen
                    Navigator.pushNamed(context, '/home');
                     txt_nom.text='';
                     txt_prenom.text='';
                     txt_email.text='';
                     txt_number.text='';
                  }).catchError((error) {
                    // Error handling
                    print('Failed to add data: $error');
                  });
                },


                child: Text(
                   LanguageTranslation.of(context)!.value('Confirmer'),
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        ),
      ),


    );
  }
}