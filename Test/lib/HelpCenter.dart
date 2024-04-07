import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test/model/profile.dart';
import 'package:test/search.dart';
import 'component/drawer.dart';
import 'Home.dart';
import 'component/nav.dart';

class Help extends StatefulWidget {
  final Map<String, dynamic> info;
  final Profile profile;

  const Help({
    Key? key,
    required this.profile,
    required this.info,
  }) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  TextEditingController _feedbackController = TextEditingController();

  void _addFeedback() {
  FirebaseFirestore.instance
      .collection('Feedbacks')
      .doc(widget.profile.email)
      .set({
    DateTime.now().millisecondsSinceEpoch.toString(): {
      'issue': _feedbackController.text,
      'report_date': FieldValue.serverTimestamp(),
    }
  }, SetOptions(merge: true)).then((_) {
    Fluttertoast.showToast(
      msg: 'We have collected your feedback, thank you',
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      backgroundColor: Color(0xFFA04826),
      timeInSecForIosWeb: 3,
    );
    _feedbackController.clear(); // Clear text field after sending feedback
  }).catchError((error) {
    Fluttertoast.showToast(
      msg: 'Failed to collect feedback: $error',
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      backgroundColor: Color(0xFFA04826),
      timeInSecForIosWeb: 3,
    );
    print(error);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(profile: widget.profile, info: widget.info),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Bar(profile: widget.profile, info: widget.info),
        ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
            ),
            child: SizedBox(height: 350),
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
                  controller: _feedbackController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide(color: Color(0xFFA04826)),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        if (_feedbackController.text.isNotEmpty) {
                          _addFeedback();
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Please enter your feedback',
                            gravity: ToastGravity.TOP,
                            textColor: Colors.white,
                            backgroundColor: Color(0xFFA04826),
                            timeInSecForIosWeb: 3,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.send, color: Color(0xFFA04826)),
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  style: TextStyle(color: Color(0xFFA04826)),
                ),
                SizedBox(height: 20),
                Text(
                  'As soon as we find a solution, we will announce it via email.\nThank you!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFFA04826),
                      fontSize: 15.0,
                      fontFamily: 'EncodeSansCondensed',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
