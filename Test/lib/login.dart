import 'package:flutter/material.dart';
import 'Home.dart';

class LoginApp extends StatefulWidget {
  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
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
          // Text
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
          // TextField - Username
          Positioned(
            bottom: 250,
            left: 20,
            right: 20,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Username', // Customized hint text
                hintStyle: TextStyle(
                  color: Color(0xFFA04826),
                  fontFamily: 'EncodeSansCondensed',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFA04826)),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.person, color: Color(0xFFA04826)),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              ),
              onChanged: (value) {
                print('Problem report: $value');
              },
              style: TextStyle(color: Color(0xFFA04826)),
            ),
          ),
          // TextField - Password
          Positioned(
            bottom: 180,
            left: 20,
            right: 20,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Password', // Customized hint text
                hintStyle: TextStyle(
                  color: Color(0xFFA04826),
                  fontFamily: 'EncodeSansCondensed',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFA04826)),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.lock, color: Color(0xFFA04826)),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              ),
              onChanged: (value) {
                print('Problem report: $value');
              },
              style: TextStyle(color: Color(0xFFA04826)),
            ),
          ),
          // Buttons
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFFA04826), 
                    backgroundColor: Colors.transparent, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Color(0xFFA04826)),
                    ),
                  ),
                  child: Text('Log In', style: TextStyle(
                  color: Color(0xFFA04826),
                  fontFamily: 'EncodeSansCondensed',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),), // Button text
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add onPressed functionality for Button 2 here
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFFA04826), 
                    backgroundColor: Colors.transparent, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Color(0xFFA04826)),
                    ),
                  ),
                  child: Text('Sign Up', style: TextStyle(
                  color: Color(0xFFA04826),
                  fontFamily: 'EncodeSansCondensed',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),), // Button text
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
