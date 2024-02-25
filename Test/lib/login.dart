import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'component/login_component.dart';
import 'component/signup_component.dart';

class LoginApp extends StatefulWidget {
  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  bool _isLogin = true;

  // Store the last tapped button
  bool _lastTappedIsLogin = true;

  // Method to toggle to login mode
  void _toggleLogin() {
    setState(() {
      _lastTappedIsLogin = true;
      _isLogin = true;
    });
    formKey.currentState!.reset();
  }

  // Method to toggle to signup mode
  void _toggleSignup() {
    setState(() {
      _lastTappedIsLogin = false;
      _isLogin = false;
    });
    formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.fill,
            ),
          ),
          // Logo Image
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/logo.jpg',
                height: 200, // Adjust the height as needed
              ),
            ),
          ),
          // text
          Positioned(
            top: 220,
            left: 20,
            right: 20,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Where Movie Nights Feel Like Warm Hugs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'EncodeSansCondensed',
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          _isLogin
              ? LoginComponent(toggleSignup: _toggleSignup)
              : SignupComponent(toggleLogin: _toggleLogin),
        ],
      ),
    );
  }
}
