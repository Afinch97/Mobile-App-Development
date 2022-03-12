import 'package:chatapp/screens/homePage.dart';
import 'package:chatapp/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Driver extends StatelessWidget {
  Driver({Key? key}) : super(key: key);
  static const String routeName = '/driver';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    var stream = _auth.idTokenChanges();
    stream.listen((event) {});
    if (_auth.currentUser != null) {
      return HomePage();
    } else {
      return const SignUpPage();
    }
  }
}
