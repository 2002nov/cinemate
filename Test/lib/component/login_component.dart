import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:test/Home.dart'; // Import your Home widget
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:test/User.dart';
import 'package:test/model/profile.dart';
import 'package:test/component/signup_component.dart';
import 'package:test/users.dart';

final Profile profile = Profile(
  username: '',
  password: '',
  phone: '',
  email: '',
);

class LoginComponent extends StatelessWidget {
  final VoidCallback toggleSignup; // Callback to toggle to signup mode

  LoginComponent({required this.toggleSignup});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 120,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    try {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: profile.email, password: profile.password)
                          .then((value) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return UserDetailsPage(
                              profile: profile);
                        }
                        ));
                      });
                    } on FirebaseAuthException catch (e) {
                      Fluttertoast.showToast(
                        msg: e.message ?? 'An error occurred',
                        gravity: ToastGravity.TOP,
                        textColor: Colors.white,
                        backgroundColor: Color(0xFFA04826),
                        timeInSecForIosWeb: 3,
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFFA04826),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Color(0xFFA04826)),
                  ),
                ),
                child: Text(
                  'Log In',
                  style: TextStyle(
                    color: Color(0xFFA04826),
                    fontFamily: 'EncodeSansCondensed',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: toggleSignup, // Call the toggleSignup callback
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFFA04826),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Color(0xFFA04826)),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'EncodeSansCondensed',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        LoginComponentContent(),
      ],
    );
  }
}

class LoginComponentContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 180,
      left: 25,
      right: 40,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            // TextFormField - Email
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.person, color: Color(0xFFA04826)),
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              ),
              onChanged: (value) {
                profile.email = value;
              },
              onSaved: (value) {
                if (value != null) {
                  profile.email = value;
                }
              },
              validator: MultiValidator([
                RequiredValidator(errorText: 'Please enter your email'),
                EmailValidator(errorText: 'Incorrect email format'),
              ]),
              style: TextStyle(color: Color(0xFFA04826)),
            ),
            // TextFormField - Password
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.lock, color: Color(0xFFA04826)),
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              ),
              onChanged: (value) {
                profile.password = value;
              },
              onSaved: (value) {
                if (value != null) {
                  profile.password = value;
                }
              },
              validator: MultiValidator([
                RequiredValidator(errorText: 'Please enter your password'),
              ]),
              style: TextStyle(color: Color(0xFFA04826)),
            ),
          ],
        ),
      ),
    );
  }
}
