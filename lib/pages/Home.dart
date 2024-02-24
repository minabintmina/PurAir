import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(
              color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        // Set the app bar background color to purple
        shadowColor: Colors.purple,

        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _Deconnexion(context),
          ),
        ],
      ),
      body: Container(
      padding: EdgeInsets.all(10),
      child: Text("home"),
    ),
    );
  }
  Future<void> _Deconnexion(BuildContext context) async {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, '/Form', (route) => false);
  }
}