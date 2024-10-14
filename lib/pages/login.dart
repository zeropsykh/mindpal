import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  Login({super.key});

  Future<http.Response> loginRequest(String username, String password) {
    return http.post(
      Uri.parse("https://mindpal-jnvk.onrender.com/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
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
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/images/mindpal_logo.jpg'),
              ),
              const SizedBox(height: 28.0),
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
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: 500,
                child: TextField(
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
                ),
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Implement forgot password logic
                      },
                      child: const Text('Forgot Password?',
                          style: TextStyle(color: Colors.teal)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Implement login logic

                        String username = usernameController.text;
                        String password = passwordController.text;

                        loginRequest(username, password);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        minimumSize: const Size(120, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text('Create Account',
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
