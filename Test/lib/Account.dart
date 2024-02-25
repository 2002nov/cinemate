import 'package:flutter/material.dart';
import 'package:test/model/profile.dart';
import 'component/drawer.dart';
import 'Home.dart';
import 'component/nav.dart';


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
  @override
Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: NavDrawer(profile: widget.profile, info: widget.info),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Bar(profile: widget.profile, info: widget.info),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: AccountForm(),
          ),
        ),
      ),
    );
  }
}

class AccountForm extends StatefulWidget {
  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phonenumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Account Mangament',
            style: TextStyle(color: Colors.white, fontSize: 25),
            textAlign: TextAlign.center,),
            SizedBox(height: 20,),
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.account_circle,
              size: 80.0,
              color: Colors.black,
            ),
          ),
          SizedBox(height:20),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              labelStyle: TextStyle(color: Color(0xFFA04826)), // Set text color
            ),
            style: TextStyle(color: Colors.white), // Set text color
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white, fontFamily: 'EncodeSansCondensed',), // Set text color
            ),
            style: TextStyle(color: Colors.white, fontFamily: 'EncodeSansCondensed',), // Set text color
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              }
              // You can add more email validation if needed
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white, fontFamily: 'EncodeSansCondensed',), // Set text color
            ),
            style: TextStyle(color: Colors.white, fontFamily: 'EncodeSansCondensed',), // Set text color
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _phonenumController,
            decoration: InputDecoration(
              labelText: 'Phonenumber',
              labelStyle: TextStyle(color: Colors.white, fontFamily: 'EncodeSansCondensed',), // Set text color
            ),
            style: TextStyle(color: Colors.white, fontFamily: 'EncodeSansCondensed',), // Set text color
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an Phonenumber';
              }
              // You can add more email validation if needed
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Validate the form
              if (_formKey.currentState?.validate() ?? false) {
                
                String username = _usernameController.text;
                String email = _emailController.text;
                String password = _passwordController.text;
                String Phonenumber = _phonenumController.text;
                // TODO: Handle account creation logic
                print('Account created - Username: $username, Email: $email, Password: $password');
              }
            },
            style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFA04826), // Set the button color here
            ),
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white, fontFamily: 'EncodeSansCondensed',), // Set text color
            ),
          ),
          SizedBox(height: 20),
          // Additional Text widget at the bottom
          Text(
            'Privacy',
            style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'EncodeSansCondensed',),
          ),
          Divider(
            color: Colors.white,
            thickness: 2.0,
          ),

        Text(
            'Privacy is flakejl;aeoibjsaeiobjspjbspyvcyuaevyuvauvciuagbcuiabvuibauibvuibaiuvbauebuiavavbaueibvuaibvuiaebuifbauivdbkgkjsgfkjvcxkusf',
            style: TextStyle(color: Colors.white, fontFamily: 'EncodeSansCondensed',),
          ),
        ],
      ),
    );
  }
}
