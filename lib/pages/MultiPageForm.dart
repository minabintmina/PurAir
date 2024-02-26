import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../classes/LanguageTranslation.dart';

class MultiPageForm extends StatefulWidget {
  final String languageCode;

  const MultiPageForm({Key? key, required this.languageCode}) : super(key: key);

  @override
  _MultiPageFormState createState() => _MultiPageFormState();
}

class _MultiPageFormState extends State<MultiPageForm> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  late bool _isEnglish;
  bool numberExists = false;
  bool emailExists = false;

  TextEditingController txt_nom = TextEditingController();
  TextEditingController txt_prenom = TextEditingController();
  TextEditingController txt_number = TextEditingController();
  TextEditingController txt_email = TextEditingController();

  TextEditingController txt_healthInfo = TextEditingController();
  TextEditingController txt_smokingInfo = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("Received language code in FormFiels: ${widget.languageCode}");
    _isEnglish = widget.languageCode != 'ar'; // Set language based on language code
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: Text('BRRRRRRRRRR'),
          centerTitle: true,
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentPageIndex,
            onStepCancel: () => _currentPageIndex == 0
                ? null
                : setState(() {
              _currentPageIndex -= 1;
            }),
            onStepContinue: () async {
              bool isValid = await _validateCurrentPage();
              if (isValid) {
                bool isLastStep = (_currentPageIndex == getSteps().length - 1);
                if (isLastStep) {
                  _submitForm();
                } else {
                  setState(() {
                    _currentPageIndex += 1;
                  });
                }
              }
            },
            onStepTapped: (step) => setState(() {
              _currentPageIndex = step;
            }),
            steps: getSteps(),
          )),
    );
  }

  Future<void> _submitForm() async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'nom': txt_nom.text,
        'prenom': txt_prenom.text,
        'email': txt_email.text,
        'number': txt_number.text,
        'health_info': txt_healthInfo.text,
        'smoking_info': txt_smokingInfo.text,
      });
      Navigator.pushNamed(context, '/home');
      txt_nom.clear();
      txt_prenom.clear();
      txt_email.clear();
      txt_number.clear();
      txt_healthInfo.clear();
      txt_smokingInfo.clear();
    } catch (error) {
      print('Failed to add data: $error');
    }
  }

  Future<bool> _validateCurrentPage() async {
    switch (_currentPageIndex) {
      case 0:
        return _validatePersonalInfo();
      case 1:
        return _validateHealthInfo();
      case 2:
        return _validateSmokingInfo();
      default:
        return true;
    }
  }


  Future<bool> _validatePersonalInfo() async {
    // Check if any of the fields are empty
    if (txt_nom.text.isEmpty ||
        txt_prenom.text.isEmpty ||
        txt_email.text.isEmpty ||
        txt_number.text.isEmpty) {
      // Check each field individually and show the appropriate message
      String errorMessage = '';
      if (txt_nom.text.isEmpty) {
        errorMessage += LanguageTranslation.of(context)!.value('NomRequired') + '\n';
      }
      if (txt_prenom.text.isEmpty) {
        errorMessage += LanguageTranslation.of(context)!.value('PrenomRequired') + '\n';
      }
      if (txt_email.text.isEmpty) {
        errorMessage += LanguageTranslation.of(context)!.value('EmailRequired') + '\n';
      }
      if (txt_number.text.isEmpty) {
        errorMessage += LanguageTranslation.of(context)!.value('NumberRequired');
      }

      // Show a Snackbar with the collected error messages
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false; // Exit the function if any field is empty
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
      return false;
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
      return false;
    }

    return true;
  }

  bool _validateHealthInfo() {
    // Implement validation logic for health info fields
    return true;
  }

  bool _validateSmokingInfo() {
    // Implement validation logic for smoking info fields
    return true;
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        title: Text('Personal'),
        isActive: _currentPageIndex >= 0,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50), // Adjust the height to move the form down
            Row( // Use Row instead of Column to place Nom and Prénom fields next to each other
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // Adjust the spacing between fields
              children: [
                Expanded( // Use Expanded to allow the field to take the available space
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: txt_nom,
                      cursorColor: Colors.green,
                      // Set cursor color to green
                      textDirection: _isEnglish
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                            Icons.account_circle_outlined, color: Colors.green),
                        hintText: LanguageTranslation.of(context)!.value('Nom'),
                        border: InputBorder.none,
                        focusColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LanguageTranslation.of(context)!.value(
                              'NomRequired');
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Add spacing between Nom and Prénom fields
                Expanded( // Use Expanded to allow the field to take the available space
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: txt_prenom,
                      cursorColor: Colors.green,
                      // Set cursor color to green
                      textDirection: _isEnglish
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                            Icons.account_circle_outlined, color: Colors.green),
                        hintText: LanguageTranslation.of(context)!.value(
                            'Prénom'),
                        border: InputBorder.none,
                        focusColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LanguageTranslation.of(context)!.value(
                              'PrenomRequired');
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: txt_email,
                cursorColor: Colors.green,
                // Set cursor color to green
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.green),
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
                    return LanguageTranslation.of(context)!.value(
                        'EmailRequired');
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: txt_number,
                cursorColor: Colors.green,
                // Set cursor color to green
                decoration: InputDecoration(
                  prefixIcon: Icon(
                      Icons.add_ic_call_outlined, color: Colors.green),
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
                    return LanguageTranslation.of(context)!.value(
                        'NumberRequired');
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      Step(
        title: Text('Health'),
        isActive: _currentPageIndex >= 1,
        content: Column(
          children: [
            TextFormField(
              controller: txt_healthInfo,
              decoration: InputDecoration(labelText: 'Health Info'),
            ),
          ],
        ),
      ),
      Step(
        title: Text('Smoking'),
        isActive: _currentPageIndex >= 2,
        content: Column(
          children: [
            TextFormField(
              controller: txt_smokingInfo,
              decoration: InputDecoration(labelText: 'Smoking Info'),
            ),
          ],
        ),
      ),
    ];
  }
}
