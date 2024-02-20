import 'package:flutter/material.dart';
import 'HelpCenter.dart';
import 'Home.dart';
import 'Account.dart';
import 'login.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String _selectedItem = 'Home';
  Color _tileColor = Colors.white;

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
                setState(() {
                  _selectedItem = 'Home';
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              }),
              _buildListItem('TV shows', () {
                setState(() {
                  _selectedItem = 'TV shows';
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              }),
              _buildListItem('Movies', () {
                setState(() {
                  _selectedItem = 'Movies';
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              }),
              _buildListItem('New & Popular', () {
                setState(() {
                  _selectedItem = 'New & Popular';
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              }),
              _buildListItem('My List', () {
                setState(() {
                  _selectedItem = 'My List';
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              }),
              _buildListItem('Bowse By Language', () {
                setState(() {
                  _selectedItem = 'Bowse By Language';
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Divider(color: Colors.white), 
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: _tileColor, // Use the color variable
                ),
                title: Text(
                  'Account', 
                  style: TextStyle(
                    color: _tileColor, // Use the color variable
                    fontFamily: 'EncodeSansCondensed',
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedItem = 'Account';
                    _tileColor = Color(0xFFA04826); // Change color when tapped
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Account(),
                    ),
                  );
                },
              ),          
              ListTile(
                leading: Image.asset(
                  'assets/manual.png', // Replace 'your_image.png' with the path to your image asset
                  width: 24, // Adjust width as needed
                  height: 24, // Use the color variable
                ),
                title: Text(
                  'Help Center', 
                  style: TextStyle(
                    color: _tileColor, // Use the color variable
                    fontFamily: 'EncodeSansCondensed',
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedItem = 'HelpCenter';
                    _tileColor = Color(0xFFA04826);
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Help(),
                    ),
                  );
                },
              ), 
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
                  child: Text('Log Out', style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'EncodeSansCondensed',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),), // Button text
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
          color: Colors.white,
          fontFamily: 'EncodeSansCondensed',
          fontSize: 15,
          fontWeight: FontWeight.bold
        ),
      ),
      onTap: () {
        setState(() {
          _selectedItem = title;
          _tileColor = Color(0xFFA04826); 
        }
      );
    }
    );
  }
}
