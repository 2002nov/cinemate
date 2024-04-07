import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/Lang.dart';
import 'package:test/MyListpage.dart';
import 'package:test/Moviepage.dart';
import 'package:test/Pop.dart';
import 'package:test/edit.dart';
import 'package:test/model/profile.dart';
import '../HelpCenter.dart';
import '../Home.dart';
import '../Account.dart';
import '../Tv.dart';
import '../login.dart';

class NavDrawer extends StatefulWidget {
  final Map<String, dynamic> info;
  final Profile profile;

  const NavDrawer({
    Key? key,
    required this.profile,
    required this.info,
  }) : super(key: key);
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String _selectedItem = 'Home';
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  TextEditingController _nameController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.info['name'];
    _imageController.text = widget.info['image'];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.profile.email).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("Document does not exist"));
          }

          // Accessing subcollection data
          var data = snapshot.data!.data() as Map<String, dynamic>;
          var info = data[widget.info['infoid']] as Map<String, dynamic>;

          return ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          info['image'],
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), // Adjust opacity here
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    height: 180,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to a new page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Edit(
                                  profile: widget.profile,
                                  info: widget
                                      .info)), // Replace NewPage with the desired destination
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10, top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                info['image'],
                              ),
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child: Text(
                                info['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'EncodeSansCondensed',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _buildListItem('Home', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Home(profile: widget.profile, info: widget.info),
                  ),
                );
              }),
              _buildListItem('TV shows', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Tv(profile: widget.profile, info: widget.info),
                  ),
                );
              }),
              _buildListItem('Movies', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Moviepage(profile: widget.profile, info: widget.info),
                  ),
                );
              }),
              _buildListItem('New & Popular', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Pop(profile: widget.profile, info: widget.info),
                  ),
                );
              }),
              _buildListItem('My List', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        MyListPage(profile: widget.profile, info: widget.info),
                  ),
                );
              }),
              _buildListItem('Browse By Language', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Lang(profile: widget.profile, info: widget.info),
                  ),
                );
              }),
              SizedBox(height: 10),
              Divider(color: Colors.white),
              SizedBox(height: 10),
              _buildListItem('Account', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Account(profile: widget.profile, info: widget.info),
                  ),
                );
              }),
              _buildListItem('Help Center', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Help(profile: widget.profile, info: widget.info),
                  ),
                );
              }),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        SizedBox(
                            width:
                                5), // Adding some space between the icon and the text
                        Text(
                          'Log Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'EncodeSansCondensed',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
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
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}
