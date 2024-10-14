import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Future<Text> signUpRequest(String name, String username, String email,
      String phoneNo, String password) async {
    final response = await http.post(
      Uri.parse("https://mindpal-jnvk.onrender.com/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'username': username,
        'email': email,
        'phone_no': phoneNo,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return Text("User {name} created");
    } else {
      throw Exception('Failed to create user.');
    }
  }

  bool emailValidator(String email) {
    final RegExp emailRegExp = RegExp(
        r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+");
    return emailRegExp.hasMatch(email);
  }

  final signUpKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneNoController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Center(
            child: Text(
              'MindPal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28, // Adjust the font size as needed
                fontWeight: FontWeight.w500,
                fontFamily: "Open Sans", // Replace with your desired font name
              ),
            ),
          ),
        ),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Form(
              key: signUpKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 75,
                    backgroundImage:
                        AssetImage('assets/images/mindpal_logo.jpg'),
                  ),
                  const SizedBox(height: 28.0),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9_]')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: phoneNoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      String name = nameController.text;
                      String username = usernameController.text;
                      String email = emailController.text;
                      String phoneNo = phoneNoController.text;
                      String password = passwordController.text;
                      String confirmPassword = confirmPasswordController.text;

                      if (!emailValidator(email)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid Email')),
                        );
                      }

                      if (signUpKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Password does not match')),
                        );
                      }

                      signUpRequest(name, username, email, phoneNo, password);
                      print("user created");

                      // Implement signup logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(120, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 24.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: const Text('Back to Login',
                        style: TextStyle(color: Colors.teal)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
