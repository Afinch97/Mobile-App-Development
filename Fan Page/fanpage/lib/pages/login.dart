import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fanpage/pages/signup.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login(context);
                      }
                    },
                    child: const Text("Log In")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: const Text("Register")),
                TextButton(
                    onPressed: () {}, child: const Text("Forgot Password"))
              ],
            ),
          )),
    ));
  }

  void _login(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
      ScaffoldMessenger.of(context).clearSnackBars();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
        ModalRoute.withName('/'),
      );
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email or password is incorrect")));
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
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
