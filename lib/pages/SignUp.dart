import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatelessWidget {
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_motdepass = new TextEditingController();
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SignUp Page',
          style: TextStyle(color: Colors.white), // Set the app bar text color to white
        ),
        backgroundColor: Colors.purple, // Set the app bar background color to purple
        shadowColor: Colors.purple,
      ),body: Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            controller: txt_login,
            cursorColor: Colors.purple,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle_sharp),
                prefixStyle: TextStyle(color: Colors.purple),
                prefixIconColor: Colors.purple,
                hintText: 'subscribe',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.purple),
                  borderRadius: BorderRadius.circular(20),
                ),focusColor: Colors.purple
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            controller: txt_motdepass,
            cursorColor: Colors.purple,
            obscureText: true,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                prefixStyle: TextStyle(color: Colors.purple),
                prefixIconColor: Colors.purple,
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.purple),
                  borderRadius: BorderRadius.circular(20),
                ),focusColor: Colors.purple
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                primary: Colors.purple,
                shadowColor: Colors.purple// Set the button color to purple
            ),
            onPressed: () {
              _onInscrire(context);
            },
            child: Text(
              'Registration',
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
        TextButton(
          child: Text(
            "I have an account",
            style: TextStyle(fontSize: 22,color: Colors.purple),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/Login');
          },
        ),
      ],
    ),
    );
  }

  Future<void> _onInscrire(BuildContext context) async {
    if (!txt_login.text.isEmpty && !txt_motdepass.text.isEmpty) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: txt_login.text.trim(), password: txt_motdepass.text.trim());
        await FirebaseFirestore.instance.collection('users').add({
          'email': txt_login.text.trim(),
        });
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        SnackBar snackBar = SnackBar(content: Text(""));
        if (e.code == 'weak-password') {
          snackBar = SnackBar(
            content: Text("Mot de passe faible"),
          );
        } else if (e.code == "email-already-in-use") {
          snackBar = SnackBar(
            content: Text("Email déjà existant"),
          );
        }
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      const snackBar = SnackBar(content: Text("Id ou mot de passe vides"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
