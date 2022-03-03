import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  static const String routeName = '/help';
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Help")));
  }
}
