import 'package:flutter/material.dart';
import 'package:test/Lang.dart';
import 'package:test/MyListpage.dart';
import 'package:test/Moviepage.dart';
import 'package:test/Pop.dart';
import '../HelpCenter.dart';
import '../Home.dart';
import '../Account.dart';
import '../Tv.dart';
import '../login.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String _selectedItem = 'Home';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      child: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(
            children: <Widget>[
              _buildListItem('Home', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              }),
              _buildListItem('TV shows', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Tv(),
                  ),
                );
              }),
              _buildListItem('Movies', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Moviepage(),
                  ),
                );
              }),
              _buildListItem('New & Popular', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Pop(),
                  ),
                );
              }),
              _buildListItem('My List', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyListPage(),
                  ),
                );
              }),
              _buildListItem('Browse By Language', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Lang(),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Divider(color: Colors.white),
              ),
              _buildListItem('Account', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Account(),
                  ),
                );
              }),
              _buildListItem('Help Center', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Help(),
                  ),
                );
              }),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginApp(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                child: Text(
                  'Log Out',
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
      ),
    );
  }

  Widget _buildListItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color:Colors.white,
          fontFamily: 'EncodeSansCondensed',
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        setState(() {
          _selectedItem = title;
        });
        onTap();
      },
    );
  }
}