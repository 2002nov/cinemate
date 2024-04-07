import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:test/model/profile.dart';
import 'component/drawer.dart';
import 'Home.dart';
import 'component/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Account extends StatefulWidget {
  final Map<String, dynamic> info;
  final Profile profile;

  const Account({
    Key? key,
    required this.profile,
    required this.info,
  }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  DateTime? _fetchedCreateAt;

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget initializes
    fetchDateData();
  }

  Future<Map<String, dynamic>?> getUserData(String doc) async {
    try {
      // Access Firestore and retrieve the document
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.profile.email)
          .get();

      // Check if the document exists
      if (!docSnapshot.exists) {
        throw Exception('Document does not exist');
      }

      Timestamp createAt =
          docSnapshot.get('createAt'); // Get 'createAt' timestamp

      return {
        'createAt':
            createAt // Include 'createAt' timestamp in the returned data
      };
    } catch (e) {
      print('Error retrieving user data: $e');
      return null;
    }
  }

  Future<void> fetchDateData() async {
    // Fetch user data
    print('Fetching user data...');
    Map<String, dynamic>? userData = await getUserData(widget.profile.email);
    if (userData != null) {
      // Get the 'createAt' timestamp from userData
      Timestamp createAt = userData['createAt'];
      print('Fetched timestamp: $createAt');

      // Set the fetched data to the respective variable
      setState(() {
        _fetchedCreateAt = createAt.toDate(); // Convert Timestamp to DateTime
        print('Converted DateTime: $_fetchedCreateAt');
      });
    } else {
      print('Failed to fetch user data');
    }
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'EncodeSansCondensed',
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.person,
                  color: Color(0xFFA04826),
                  size: 30,
                ),
                SizedBox(width: 5),
                Text(
                  _fetchedCreateAt != null
                      ? 'Member since ${DateFormat('yyyy-MM-dd').format(_fetchedCreateAt!)}'
                      : 'N/A',
                  style: TextStyle(
                    color: Color.fromARGB(255, 123, 110, 105),
                    fontFamily: 'EncodeSansCondensed',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.white,
              thickness: 2.0,
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              child: AccountForm(info: widget.info, profile: widget.profile),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountForm extends StatefulWidget {
  final Map<String, dynamic> info;
  final Profile profile;

  AccountForm({required this.info, required this.profile});

  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm>
    with AutomaticKeepAliveClientMixin<AccountForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phonenumController = TextEditingController();

  String? _fetchedUsername;
  String? _fetchedPhoneNumber;
  String? _fetchedEmail;
  String? _fetchedPassword;

  @override
  bool get wantKeepAlive => true;

  Future<void> updateAuthUserData(String newEmail, String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        if (newEmail.isNotEmpty) {
          await user.updateEmail(newEmail);
          await user.sendEmailVerification(); // Send email verification
        }

        if (newPassword.isNotEmpty) {
          await user.updatePassword(newPassword);
        }
      } else {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user currently signed in.',
        );
      }
    } on FirebaseAuthException catch (e) {
      print('Failed to update user data: $e');
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  Future<void> updateUserData(
      String userId, Map<String, dynamic> newData) async {
    try {
      // Check if newData is not empty
      if (newData.isNotEmpty) {
        // Perform additional data validation if needed

        // Update user data in Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .update(newData);

        // Show a success toast message
        Fluttertoast.showToast(
          msg: 'User data updated successfully',
          gravity: ToastGravity.TOP,
          textColor: Colors.white,
          backgroundColor: Color(0xFFA04826),
          timeInSecForIosWeb: 3,
        );
      } else {
        // If newData is empty, no update needed
        // Show an error toast message
        Fluttertoast.showToast(
          msg: 'No data update',
          gravity: ToastGravity.TOP,
          textColor: Colors.white,
          backgroundColor: Color(0xFFA04826),
          timeInSecForIosWeb: 3,
        );
      }
    } catch (e) {
      // Show an error toast message
      Fluttertoast.showToast(
        msg: 'Failed to update user data: $e',
        gravity: ToastGravity.TOP,
        textColor: Colors.white,
        backgroundColor: Color(0xFFA04826),
        timeInSecForIosWeb: 3,
      );
    }
  }

  Future<Map<String, dynamic>?> getUserData(String doc) async {
    try {
      // Access Firestore and retrieve the document
      DocumentSnapshot docSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(doc).get();

      // Check if the document exists
      if (!docSnapshot.exists) {
        throw Exception('Document does not exist');
      }

      String phone = docSnapshot.get('phone');
      String username = docSnapshot.get('username');
      String password = docSnapshot.get('password');
      String email = docSnapshot.get('email');

      return {
        'username': username,
        'phone': phone,
        'password': password,
        'email': email
      };
    } catch (e) {
      print('Error retrieving user data: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget initializes
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Fetch user data
    Map<String, dynamic>? userData = await getUserData(widget.profile.email);
    if (userData != null) {
      // Get username from userData
      String username = userData['username'];
      String phone = userData['phone'];
      String email = userData['email'];
      String password = userData['password'];

      // Set the fetched username to the _fetchedUsername variable
      setState(() {
        _fetchedUsername = username;
        _fetchedEmail = email;
        _fetchedPassword = password;
        _fetchedPhoneNumber = phone;
      });
    } else {
      print('Failed to fetch user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Username TextFormField
            Row(
              children: [
                SizedBox(
                  width: 100, // Set a fixed width for the labels
                  child: Text(
                    'Username',
                    style: TextStyle(
                      color: Color(0xFFA04826),
                      fontFamily: 'EncodeSansCondensed',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _usernameController,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'EncodeSansCondensed'),
                    decoration: InputDecoration(
                      hintText: _fetchedUsername ?? 'Enter your username',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 15,
                        fontFamily: 'EncodeSansCondensed',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Email TextFormField
            Row(
              children: [
                SizedBox(
                  width: 100, // Set a fixed width for the labels
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: Color(0xFFA04826),
                      fontFamily: 'EncodeSansCondensed',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'EncodeSansCondensed'),
                    decoration: InputDecoration(
                      hintText: _fetchedEmail ?? 'Enter your email',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 15,
                        fontFamily: 'EncodeSansCondensed',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      // Check if value is null or empty
                      if (value == null || value.isEmpty) {
                        return null; // Return null to indicate no error
                      }
                      // Apply email format validation if value is not null or empty
                      return EmailValidator(errorText: 'Incorrect email format')
                          .call(value);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Password TextFormField
            Row(
              children: [
                SizedBox(
                  width: 100, // Set a fixed width for the labels
                  child: Text(
                    'Password',
                    style: TextStyle(
                      color: Color(0xFFA04826),
                      fontFamily: 'EncodeSansCondensed',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _passwordController,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'EncodeSansCondensed'),
                    decoration: InputDecoration(
                      hintText: _fetchedPassword ?? 'Enter your password',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 15,
                        fontFamily: 'EncodeSansCondensed',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      // Check if the value is null or empty
                      if (value == null || value.isEmpty) {
                        return null; // Return null to indicate no error if value is null or empty
                      }

                      // Apply custom validation for length less than 8
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }

                      return null; // Return null to indicate no error
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Phone number TextFormField
            Row(
              children: [
                SizedBox(
                  width: 100, // Set a fixed width for the labels
                  child: Text(
                    'Phone number',
                    style: TextStyle(
                      color: Color(0xFFA04826),
                      fontFamily: 'EncodeSansCondensed',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _phonenumController,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'EncodeSansCondensed'),
                    decoration: InputDecoration(
                      hintText:
                          _fetchedPhoneNumber ?? 'Enter your phone number',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 15,
                        fontFamily: 'EncodeSansCondensed',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Save Button
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Set the desired width of the button
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Validate the form
                    if (_formKey.currentState?.validate() ?? false) {
                      // Prepare updated user data
                      Map<String, dynamic> newData = {};

                      // Check if the username field is not empty
                      if (_usernameController.text.isNotEmpty) {
                        newData['username'] = _usernameController.text;
                      }

                      // Check if the email field is not empty
                      if (_emailController.text.isNotEmpty) {
                        try {
                          // Update the user's email in Firebase Authentication
                          await FirebaseAuth.instance.currentUser
                              ?.updateEmail(_emailController.text);

                          // Send email verification
                          await FirebaseAuth.instance.currentUser
                              ?.sendEmailVerification();

                          // If successful, update the 'email' field in the newData map
                          newData['email'] = _emailController.text;
                        } catch (e) {
                          // Handle any errors that occur during the email update process

                          Fluttertoast.showToast(
                            msg: 'Failed to update email: $e',
                            gravity: ToastGravity.TOP,
                            textColor: Colors.white,
                            backgroundColor: Color(0xFFA04826),
                            timeInSecForIosWeb: 3,
                          );
                        }
                      }

                      // Check if the password field is not empty
                      if (_passwordController.text.isNotEmpty) {
                        try {
                          // Update the user's email in Firebase Authentication
                          await FirebaseAuth.instance.currentUser
                              ?.updatePassword(_passwordController.text);
                          // If successful, update the 'email' field in the newData map
                          newData['password'] = _passwordController.text;
                        } catch (e) {
                          // Handle any errors that occur during the email update process
                          Fluttertoast.showToast(
                            msg: 'Failed to update password: $e',
                            gravity: ToastGravity.TOP,
                            textColor: Colors.white,
                            backgroundColor: Color(0xFFA04826),
                            timeInSecForIosWeb: 3,
                          );
                        }
                      }

                      // Check if the phone number field is not empty
                      if (_phonenumController.text.isNotEmpty) {
                        newData['phone'] = _phonenumController.text;
                      }

                      // Update user data if newData is not empty
                      if (newData.isNotEmpty) {
                        try {
                          await updateUserData(widget.profile.email, newData);
                          print('User data updated successfully');
                        } catch (e) {
                          print('Failed to update user data: $e');
                          // Handle error accordingly, such as displaying an error message to the user
                        }
                      }
                      // Clear text fields
                      _usernameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                      _phonenumController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Colors.white), // Add white border
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Color(0xFFA04826),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Privacy Text
            Text(
              'Privacy',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'EncodeSansCondensed',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 2.0,
            ),
            // Privacy Policy Text
            Text(
              'We respect your privacy and are committed to protecting your personal information. Our app collects only the necessary data required for its functionality and does not share or sell your information to third parties.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'EncodeSansCondensed',
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Spacer(), // Add a spacer to push the text to the right
                Text(
                  'cinemate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'EncodeSansCondensed',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
