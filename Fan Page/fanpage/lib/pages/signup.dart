import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fanpage/pages/login.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static String routename = "";
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _display = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _display,
                validator: (String? value) {},
              ),
              TextFormField(
                controller: _password,
                obscureText: true,
                validator: (String? value) {
                  if (value == null) {
                    return "Password cannot be empty";
                  } else if (value.length < 8) {
                    return "your password must be 8 characters or longer";
                  }
                },
              ),
              TextFormField(
                obscureText: true,
                validator: (String? value) {
                  if (value != _password.text) {
                    return "Password must match";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _register(context);
                    }
                  },
                  child: const Text("Register")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: const Text("Login")),
              TextButton(onPressed: () {}, child: const Text("Forgot Password"))
            ],
          )),
    ));
  }

  void _register(BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);
      ScaffoldMessenger.of(context).clearSnackBars();
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "A user with that email alreadt exists in our database, if it is you please try to log in.")));
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "This password is too insecure to be used for an account")));
      }
      return;
    }

    try {
      await _db
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .set({"display_name": _display.text, "email": _email.text});
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Uknown Error has taken place")));
    }
  }
}
