import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_motdepass = new TextEditingController();
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Page',
          style: TextStyle(color: Colors.white), // Set the app bar text color to white
        ),
        backgroundColor: Colors.purple, // Set the app bar background color to purple
        shadowColor: Colors.purple,
      ),
      body: Column(
        children: [
          Container(

            padding: EdgeInsets.all(10),
            child: TextFormField(
              cursorColor: Colors.purple,
              controller: txt_login,

              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle_sharp),
                  prefixStyle: TextStyle(color: Colors.purple),
                  prefixIconColor: Colors.purple,
                  hintText: 'Login',
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
              obscureText: true,
              cursorColor: Colors.purple,
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
                primary: Colors.purple, // Set the button color to purple
              ),
              onPressed: () {
                onAuthentifier(context);
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          TextButton(
            child: Text(
              "I don't have an account",
              style: TextStyle(fontSize: 22,color: Colors.purple),

            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/SignUp');
            },
          ),
        ],
      ),
    );
  }
  Future<void> onAuthentifier(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: txt_login.text.trim(), password: txt_motdepass.text.trim());
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      SnackBar snackBar = SnackBar(content: Text(""));
      if (e.code == 'user-not-found')
        snackBar = SnackBar(content: Text('Utilisateur inexistant'));
      else if (e.code == 'wrong-password')
        snackBar = SnackBar(content: Text('Verifier votre mot de passe'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
