import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:test/model/profile.dart';

final formKey = GlobalKey<FormState>();
final Profile profile = Profile(
  username: '',
  password: '',
  phone: '',
  email: '',
);

class SignupComponent extends StatelessWidget {
  final VoidCallback toggleLogin; // Callback to toggle to login mode

  SignupComponent({required this.toggleLogin});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 60,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: toggleLogin, // Call the toggleLogin callback
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
                    color: Colors.white,
                    fontFamily: 'EncodeSansCondensed',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    try {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: profile.email,
                        password: profile.password,
                      )
                          .then((value) {
                        Fluttertoast.showToast(
                          msg: 'Welcome to Cinemate!',
                          gravity: ToastGravity.TOP,
                          textColor: Colors.white,
                          backgroundColor: Color(0xFFA04826),
                          timeInSecForIosWeb: 3,
                        );

                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(profile.email)
                            .set({
                          'username': profile.username,
                          'phone': profile.phone,
                          'email': profile.email,
                          'password': profile.password,
                            'info1': {
                              'name': 'Name1',
                              'image': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                            },
                            'info2': {
                              'name': 'Name2',
                              'image': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                            },
                            'info3': {
                              'name': 'Name3',
                              'image': 'ahttps://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                            },
                            'info4': {
                              'name': 'Name4',
                              'image': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                            },
                        });

                        formKey.currentState!.reset();
                      });
                    } on FirebaseAuthException catch (e) {
                      Fluttertoast.showToast(
                        msg: e.message ?? 'An error occurred',
                        gravity: ToastGravity.TOP,
                        textColor: Colors.white,
                        backgroundColor: Color(0xFFA04826),
                        timeInSecForIosWeb: 3,
                      );
                      formKey.currentState!.reset();
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
                  'Sign Up',
                  style: TextStyle(
                    color: Color(0xFFA04826),
                    fontFamily: 'EncodeSansCondensed',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SignupComponentContent(),
      ],
    );
  }
}

class SignupComponentContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      left: 20,
      right: 40,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            // TextFormField - Username
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Username',
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
                profile.username = value;
              },
              onSaved: (value) {
                if (value != null) {
                  profile.username = value;
                }
              },
              style: TextStyle(color: Color(0xFFA04826)),
              validator: MultiValidator([
                RequiredValidator(errorText: 'Please enter your username'),
              ]),
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
              style: TextStyle(color: Color(0xFFA04826)),
              validator: MultiValidator([
                RequiredValidator(errorText: 'Please enter your password'),
                MinLengthValidator(8,
                    errorText: 'Password must be at least 8 characters long'),
              ]),
            ),
            // TextFormField - Phone number
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Phone number',
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
                    child: Icon(Icons.phone, color: Color(0xFFA04826)),
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              ),
              onChanged: (value) {
                profile.phone = value;
              },
              onSaved: (value) {
                if (value != null) {
                  profile.phone = value;
                }
              },
              style: TextStyle(color: Color(0xFFA04826)),
              validator: MultiValidator([
                RequiredValidator(errorText: 'Please enter your phone number'),
              ]),
            ),
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
                    child: Icon(Icons.email, color: Color(0xFFA04826)),
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
              style: TextStyle(color: Color(0xFFA04826)),
              validator: MultiValidator([
                RequiredValidator(errorText: 'Please enter your email'),
                EmailValidator(errorText: 'Incorrect email format'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
