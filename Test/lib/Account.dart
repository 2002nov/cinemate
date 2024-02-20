import 'package:flutter/material.dart';
import 'drawer.dart';
import 'Home.dart';
import 'nav.dart';


class Account extends StatefulWidget {
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: Bar(),
      backgroundColor: Colors.black,
      body: Center(child: Text("Account")),
    );
  }
}