import 'package:flutter/material.dart';
import 'package:mindpal/pages/login.dart';
import 'package:mindpal/pages/prompt.dart';
import 'package:mindpal/pages/signup.dart';
//Import the LoginPage class

void main() {
  runApp(const MindPal());
}

class MindPal extends StatelessWidget {
  const MindPal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindPal',
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/prompt': (context) => Prompt(),
      },
    );
  }
}
