import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test/search.dart';
import 'component/drawer.dart';
import 'Home.dart';
import 'component/nav.dart';

class Help extends StatefulWidget {
  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: Bar(),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover, // Ensure the image covers the entire container
              ),
            ),
            child: SizedBox(height: 350), // Adjust the height as needed
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey,\nhow can we help you?',
                  style: TextStyle(
                    color: Color(0xFFA04826),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'EncodeSansCondensed',
                  ),
                ),
                SizedBox(height: 20), 
            TextField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
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
                        child: Icon(Icons.search, color: Color(0xFFA04826)),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                ),
                onChanged: (value) {
                  print('Problem report: $value');
                },
                style: TextStyle(color: Color(0xFFA04826)),
              ),
              SizedBox(height: 20),
              Text(
                'As soon as we found a solution, we will announce via email\nThank you !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFA04826),
                  fontSize: 15.0,
                  fontFamily: 'EncodeSansCondensed',
                  fontWeight: FontWeight.bold
                ),
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
