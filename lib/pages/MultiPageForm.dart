import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/LanguageTranslation.dart';

class MultiPageForm extends StatefulWidget {
  const MultiPageForm({Key? key}) : super(key: key);

  @override
  _MultiPageFormState createState() => _MultiPageFormState();
}

class _MultiPageFormState extends State<MultiPageForm> {
  int _currentPageIndex = 0;

  List<String> selectedDiseases = [];
  List<String> allDiseases = [
    "Hereditary Disease 1",
    "Hereditary Disease 2",
    "Hereditary Disease 3",
    "Hereditary Disease 4",
    // Add more diseases as needed
  ];

  List<String> selectedMentals = [];
  List<String> allMentals = [
    "Mental Disease 1",
    "Mental Disease 2",
    "Mental Disease 3",
    "Mental Disease 4",
    // Add more diseases as needed
  ];

  late bool _isEnglish;
  bool numberExists = false;
  bool emailExists = false;
  bool doYouExercise = false;
  double _motivationValue = 0; // For slider value
  bool _drinkAlcohol = false; // For checkbox value
  bool _takeDrugs = false; // For checkbox value
  bool _onMedications = false; // For checkbox value
  bool _triedQuittingBefore = false; // For checkbox value

  TextEditingController _cigarsPerDayController = TextEditingController(); // For cigars per day form field
  TextEditingController _yearsSmokingController = TextEditingController(); // For years smoking form field


  TextEditingController txt_nom = TextEditingController();
  TextEditingController txt_prenom = TextEditingController();
  TextEditingController txt_number = TextEditingController();
  TextEditingController txt_email = TextEditingController();

  TextEditingController txt_height = TextEditingController();
  TextEditingController txt_weight = TextEditingController();
  TextEditingController txt_day = TextEditingController();
  TextEditingController txt_month = TextEditingController();
  TextEditingController txt_year = TextEditingController();

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _isEnglish = true;
  }

  void _showHereditaryDiseasesDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  Text(
                    LanguageTranslation.of(context)!.value('SHD'),
                    style: TextStyle(
                      fontFamily:
                          LanguageTranslation.of(context)!.value('Font'),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    children: allDiseases.map((disease) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(disease),
                          selected: selectedDiseases.contains(disease),
                          onSelected: (isSelected) {
                            setState(() {
                              if (isSelected) {
                                selectedDiseases.add(disease);
                              } else {
                                selectedDiseases.remove(disease);
                              }
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedDiseases.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Change button color to green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Adjust button border radius
                        ),
                      ),
                      child: Text(
                        LanguageTranslation.of(context)!.value('Clear'),
                        style: TextStyle(
                          fontFamily:
                              LanguageTranslation.of(context)!.value('Font'),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showMentalDiseasesDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  Text(
                    LanguageTranslation.of(context)!.value('SMD'),
                    style: TextStyle(
                      fontFamily:
                          LanguageTranslation.of(context)!.value('Font'),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    children: allMentals.map((disease) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(disease),
                          selected: selectedMentals.contains(disease),
                          onSelected: (isSelected) {
                            setState(() {
                              if (isSelected) {
                                selectedMentals.add(disease);
                              } else {
                                selectedMentals.remove(disease);
                              }
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedMentals.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Change button color to green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Adjust button border radius
                        ),
                      ),
                      child: Text(
                        LanguageTranslation.of(context)!.value('Clear'),
                        style: TextStyle(
                          fontFamily:
                          LanguageTranslation.of(context)!.value('Font'),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Center(
            child: Text(
              LanguageTranslation.of(context)!.value('Information'),
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
      body: Theme(
        data: ThemeData(
          primarySwatch: Colors.green, // Change primary swatch color to green
          colorScheme: ColorScheme.light(
              primary: Colors
                  .green), // Change primary color in color scheme to green
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
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
            controlsBuilder:
                (BuildContext context, ControlsDetails controlsDetails) {
              return Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: controlsDetails.onStepCancel,
                      style: ElevatedButton.styleFrom(
                        primary:
                            Colors.grey, // Set button background color to grey
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20), // Add padding to the button
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Round button edges
                        ),
                      ),
                      child: Text(
                        LanguageTranslation.of(context)!.value('Annuler'),
                        style: TextStyle(
                          fontFamily:
                              LanguageTranslation.of(context)!.value('Font'),
                          fontSize: 20, // Making the title bigger
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: controlsDetails.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context)
                            .primaryColor, // Use theme primary color for continue button
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20), // Add padding to the button
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Round button edges
                        ),
                      ),
                      child: Text(
                        LanguageTranslation.of(context)!.value('TermsButton'),
                        style: TextStyle(
                          fontFamily:
                              LanguageTranslation.of(context)!.value('Font'),
                          fontSize: 20, // Making the title bigger
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            steps: getSteps(),
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = txt_email.text;
    String? language = await prefs.getString('language');
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'Firstname': txt_nom.text,
        'Lastname': txt_prenom.text,
        'Email Adresse': txt_email.text,
        'Phone Number': txt_number.text,
        'Preferred Language': language,
        'Date Of Birth': '${txt_day.text}/${txt_month.text}/${txt_year.text}',
        'Height': txt_height.text,
        'Weight': txt_weight.text,
        'Selected Hereditary Diseases': selectedDiseases,
        'Selected Mental Illnesses': selectedMentals,
        'Exercise':doYouExercise,
        'Motivation Level':_motivationValue,
        'Number Of Daily Cigars':_cigarsPerDayController.text,
        'Years Of Smoking':_yearsSmokingController.text,
        'Alcohol':_drinkAlcohol,
        'Drugs':_takeDrugs,
        'Medication':_onMedications,
        'Tried Quitting':_triedQuittingBefore

      });

      await prefs.setString('authToken', authToken);
      Navigator.pushNamed(context, '/Home');

      // Clearing text controllers
      txt_nom.clear();
      txt_prenom.clear();
      txt_email.clear();
      txt_number.clear();
      txt_day.clear();
      txt_month.clear();
      txt_year.clear();
      txt_height.clear();
      txt_weight.clear();
      _cigarsPerDayController.clear();
      _yearsSmokingController.clear();

      // Clearing selected lists
      selectedDiseases.clear();
      selectedMentals.clear();

      // Resetting boolean variables
      doYouExercise = false;
      _drinkAlcohol = false;
      _takeDrugs = false;
      _onMedications = false;
      _triedQuittingBefore = false;
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
        errorMessage +=
            LanguageTranslation.of(context)!.value('NomRequired') + '\n';
      }
      if (txt_prenom.text.isEmpty) {
        errorMessage +=
            LanguageTranslation.of(context)!.value('PrenomRequired') + '\n';
      }
      if (txt_email.text.isEmpty) {
        errorMessage +=
            LanguageTranslation.of(context)!.value('EmailRequired') + '\n';
      }
      if (txt_number.text.isEmpty) {
        errorMessage +=
            LanguageTranslation.of(context)!.value('NumberRequired');
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
    // Validate height
    if (txt_height.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LanguageTranslation.of(context)!.value('HeightRequired'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    } else {
      double height = double.tryParse(txt_height.text) ?? 0.0;
      if (height < 55 || height > 270) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              LanguageTranslation.of(context)!.value('HeightRequired2'),
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }

    // Validate weight
    if (txt_weight.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LanguageTranslation.of(context)!.value('WeightRequired'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    } else {
      double weight = double.tryParse(txt_weight.text) ?? 0.0;
      if (weight < 10 || weight > 600) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              LanguageTranslation.of(context)!.value('WeightRequired2'),
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }

    // Check if any of the date fields are empty
    if (txt_day.text.isEmpty ||
        txt_month.text.isEmpty ||
        txt_year.text.isEmpty) {
      // Show a Snackbar if any of the date fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LanguageTranslation.of(context)!.value('DateRequired'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false; // Exit the function if any field is empty
    }

    // Parse day, month, and year to integers
    int day = int.tryParse(txt_day.text) ?? 0;
    int month = int.tryParse(txt_month.text) ?? 0;
    int year = int.tryParse(txt_year.text) ?? 0;

    // Check if the year is within a valid range (e.g., after 1900)
    if (year < 1900) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LanguageTranslation.of(context)!.value('YearRequired'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Check if the month is within a valid range (1 to 12)
    if (month < 1 || month > 12) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LanguageTranslation.of(context)!.value('MonthRequired'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Check if the day is within a valid range for the given month
    if (day < 1 || day > 31) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LanguageTranslation.of(context)!.value('DayRequired1'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Check if the day is valid for February
    if (month == 2 && day > 29) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LanguageTranslation.of(context)!.value('DayRequired2'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Check if the day is valid for months with 30 days
    if ([4, 6, 9, 11].contains(month) && day > 30) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LanguageTranslation.of(context)!.value('DayRequired3'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    // All validation checks passed
    return true;
  }

  bool _validateSmokingInfo() {
    if (_cigarsPerDayController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LanguageTranslation.of(context)!.value('CigarNBRequired'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (_yearsSmokingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LanguageTranslation.of(context)!.value('CigarYearRequired'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        title: Text(
          LanguageTranslation.of(context)!.value('Personnel'),
          style: TextStyle(
            fontFamily: LanguageTranslation.of(context)!.value('Font'),
            fontSize: 15, // Making the title bigger
            color: Colors.black,
          ),
        ),
        isActive: _currentPageIndex >= 0,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30), // Adjust the height to move the form down
            Row(
              // Use Row instead of Column to place Nom and Prénom fields next to each other
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // Adjust the spacing between fields
              children: [
                Expanded(
                  // Use Expanded to allow the field to take the available space
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
                      textDirection:
                          _isEnglish ? TextDirection.ltr : TextDirection.rtl,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_outlined,
                            color: Colors.green),
                        hintText: LanguageTranslation.of(context)!.value('Nom'),
                        border: InputBorder.none,
                        focusColor: Colors.white,
                        hintStyle: TextStyle(
                          fontFamily: LanguageTranslation.of(context)!
                              .value('Font'), // Change font family
                          fontSize: 18, // Adjust font size
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Add spacing between Nom and Prénom fields
                Expanded(
                  // Use Expanded to allow the field to take the available space
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
                      textDirection:
                          _isEnglish ? TextDirection.ltr : TextDirection.rtl,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_outlined,
                            color: Colors.green),
                        hintText:
                            LanguageTranslation.of(context)!.value('Prénom'),
                        border: InputBorder.none,
                        focusColor: Colors.white,
                        hintStyle: TextStyle(
                          fontFamily: LanguageTranslation.of(context)!
                              .value('Font'), // Change font family
                          fontSize: 18, // Adjust font size
                        ),
                      ),
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
                  hintStyle: TextStyle(
                    fontFamily: LanguageTranslation.of(context)!
                        .value('Font'), // Change font family
                    fontSize: 18, // Adjust font size
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
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
                  prefixIcon:
                      Icon(Icons.add_ic_call_outlined, color: Colors.green),
                  hintText: LanguageTranslation.of(context)!.value('Téléphone'),
                  border: InputBorder.none,
                  focusColor: Colors.white,
                  hintStyle: TextStyle(
                    fontFamily: LanguageTranslation.of(context)!
                        .value('Font'), // Change font family
                    fontSize: 18, // Adjust font size
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(8),
                ],
              ),
            ),
          ],
        ),
      ),
      Step(
        title: Text(
          LanguageTranslation.of(context)!.value('Health'),
          style: TextStyle(
            fontFamily: LanguageTranslation.of(context)!.value('Font'),
            fontSize: 15, // Making the title bigger
            color: Colors.black,
          ),
        ),
        isActive: _currentPageIndex >= 1,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // Align to the right
              children: [
                Icon(
                  Icons
                      .calendar_month_outlined, // Specify the icon you want to display
                  color: Colors.green, // Set the color of the icon
                  size: 28, // Set the size of the icon
                ),
                SizedBox(width: 10),
                Text(
                  LanguageTranslation.of(context)!.value('DateOfBirth'),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: LanguageTranslation.of(context)!
                        .value('Font'), // Set font family
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              // Use Row instead of Column to place Nom and Prénom fields next to each other
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // Adjust the spacing between fields
              children: [
                Expanded(
                  // Use Expanded to allow the field to take the available space
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: txt_day,
                      cursorColor: Colors.green,
                      // Set cursor color to green
                      textDirection:
                          _isEnglish ? TextDirection.ltr : TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: LanguageTranslation.of(context)!.value('Day'),
                        border: InputBorder.none,
                        focusColor: Colors.white,
                        hintStyle: TextStyle(
                          fontFamily: LanguageTranslation.of(context)!
                              .value('Font'), // Change font family
                          fontSize: 18, // Adjust font size
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Add spacing between Nom and Prénom fields
                Expanded(
                  // Use Expanded to allow the field to take the available space
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: txt_month,
                      cursorColor: Colors.green,
                      // Set cursor color to green
                      textDirection:
                          _isEnglish ? TextDirection.ltr : TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText:
                            LanguageTranslation.of(context)!.value('Month'),
                        border: InputBorder.none,
                        focusColor: Colors.white,
                        hintStyle: TextStyle(
                          fontFamily: LanguageTranslation.of(context)!
                              .value('Font'), // Change font family
                          fontSize: 18, // Adjust font size
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  // Use Expanded to allow the field to take the available space
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: txt_year,
                      cursorColor: Colors.green,
                      // Set cursor color to green
                      textDirection:
                          _isEnglish ? TextDirection.ltr : TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText:
                            LanguageTranslation.of(context)!.value('Year'),
                        border: InputBorder.none,
                        focusColor: Colors.white,
                        hintStyle: TextStyle(
                          fontFamily: LanguageTranslation.of(context)!
                              .value('Font'), // Change font family
                          fontSize: 18, // Adjust font size
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
                controller: txt_height,
                cursorColor: Colors.green,
                // Set cursor color to green
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.height,
                      color: Colors.green), // Change icon to height icon
                  hintText: LanguageTranslation.of(context)!
                      .value('Height'), // Change hint text
                  border: InputBorder.none,
                  focusColor: Colors.white,
                  hintStyle: TextStyle(
                    fontFamily: LanguageTranslation.of(context)!
                        .value('Font'), // Change font family
                    fontSize: 18, // Adjust font size
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
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
                controller: txt_weight,
                cursorColor: Colors.green,
                // Set cursor color to green
                decoration: InputDecoration(
                  prefixIcon: Icon(
                      Icons.fitness_center,
                      color: Colors.green), // Change icon to weight icon
                  hintText: LanguageTranslation.of(context)!.value('Weight'), // Change hint text
                  border: InputBorder.none,
                  focusColor: Colors.white,
                  hintStyle: TextStyle(
                    fontFamily: LanguageTranslation.of(context)!
                        .value('Font'), // Change font family
                    fontSize: 18, // Adjust font size
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Align children to the start and end of the row
              children: [
                Expanded(
                  child: Text(
                    LanguageTranslation.of(context)!.value('Hereditary'),
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily:
                          LanguageTranslation.of(context)!.value('Font'),
                      color: Colors.black, // Change text color to black
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showHereditaryDiseasesDialog,
                  icon: Icon(Icons.check), // Use check icon
                  label: SizedBox.shrink(), // Hide button label
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Change button color to green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust button border radius
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Align children to the start and end of the row
              children: [
                Expanded(
                  child: Text(
                    LanguageTranslation.of(context)!.value('Mental'),
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily:
                          LanguageTranslation.of(context)!.value('Font'),
                      color: Colors.black, // Change text color to black
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showMentalDiseasesDialog,
                  icon: Icon(Icons.check), // Use check icon
                  label: SizedBox.shrink(), // Hide button label
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Change button color to green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust button border radius
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            CheckboxListTile(
              title: Text(
                LanguageTranslation.of(context)!.value('Exercise'),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: LanguageTranslation.of(context)!.value('Font'),
                ),
              ),
              value: doYouExercise,
              onChanged: (newValue) {
                setState(() {
                  doYouExercise = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity
                  .leading, // Place checkbox to the left of the title
              activeColor: Colors
                  .green, // Change the color of the checkmark when checkbox is checked
            ),
          ],
        ),
      ),
      Step(
        title: Text(
          LanguageTranslation.of(context)!.value('Smoking'),
          style: TextStyle(
            fontFamily: LanguageTranslation.of(context)!.value('Font'),
            fontSize: 15, // Making the title bigger
            color: Colors.black,
          ),
        ),
        isActive: _currentPageIndex >= 2,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LanguageTranslation.of(context)!.value('Motivation'),
              style: TextStyle(
                fontFamily: LanguageTranslation.of(context)!.value('Font'),
                fontSize: 16,
              ),
            ),
            Slider(
              value: _motivationValue,
              min: 0,
              max: 10,
              divisions: 10,
              onChanged: (newValue) {
                setState(() {
                  _motivationValue = newValue;
                });
              },
              label: _motivationValue.toString(),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: _cigarsPerDayController,
                cursorColor: Colors.green,
                // Set cursor color to green
                decoration: InputDecoration(
                  hintText: LanguageTranslation.of(context)!.value('CigarNB'),
                  border: InputBorder.none,
                  focusColor: Colors.white,
                  hintStyle: TextStyle(
                    fontFamily: LanguageTranslation.of(context)!
                        .value('Font'), // Change font family
                    fontSize: 16, // Adjust font size
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                controller: _yearsSmokingController,
                cursorColor: Colors.green,
                // Set cursor color to green
                decoration: InputDecoration(
                  hintText: LanguageTranslation.of(context)!.value('CigarYear'),
                  border: InputBorder.none,
                  focusColor: Colors.white,
                  hintStyle: TextStyle(
                    fontFamily: LanguageTranslation.of(context)!
                        .value('Font'), // Change font family
                    fontSize: 16, // Adjust font size
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(height: 15),
            CheckboxListTile(
              title: Text(
                LanguageTranslation.of(context)!.value('Alcohol'),
                style: TextStyle(
                  fontFamily: LanguageTranslation.of(context)!.value('Font'),
                  fontSize: 16,
                ),
              ),
              value: _drinkAlcohol,
              onChanged: (newValue) {
                setState(() {
                  _drinkAlcohol = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text(
                LanguageTranslation.of(context)!.value('Drugs'),
                style: TextStyle(
                  fontFamily: LanguageTranslation.of(context)!.value('Font'),
                  fontSize: 16,
                ),
              ),
              value: _takeDrugs,
              onChanged: (newValue) {
                setState(() {
                  _takeDrugs = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text(
                LanguageTranslation.of(context)!.value('Medication'),
                style: TextStyle(
                  fontFamily: LanguageTranslation.of(context)!.value('Font'),
                  fontSize: 16,
                ),
              ),
              value: _onMedications,
              onChanged: (newValue) {
                setState(() {
                  _onMedications = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text(
                LanguageTranslation.of(context)!.value('TriedQuitting'),
                style: TextStyle(
                  fontFamily: LanguageTranslation.of(context)!.value('Font'),
                  fontSize: 16,
                ),
              ),
              value: _triedQuittingBefore,
              onChanged: (newValue) {
                setState(() {
                  _triedQuittingBefore = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    ];
  }
}
