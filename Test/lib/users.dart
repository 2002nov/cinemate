import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/Home.dart';
import 'package:test/model/profile.dart';

class UserDetailsPage extends StatelessWidget {
  final Profile profile;

  UserDetailsPage({required this.profile});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Logo Image
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/logo.jpg',
                height: 140, // Adjust the height as needed
              ),
            ),
          ),
          // "JOIN AS" text
          Positioned(
            top: 220,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.topCenter,
              child: Text(
                'JOIN AS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'EncodeSansCondensed',
                ),
              ),
            ),
          ),
          // Info cards grid
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            bottom: 0,
            child: FutureBuilder<DocumentSnapshot>(
              future: users.doc(profile.email).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                var info1 = data['info1'] as Map<String, dynamic>;
                var info2 = data['info2'] as Map<String, dynamic>;
                var info3 = data['info3'] as Map<String, dynamic>;
                var info4 = data['info4'] as Map<String, dynamic>;

                return GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(16.0),
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(profile: profile, info: info1),
                          ),
                        );
                      },
                      child: _buildInfoCard(info1),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(profile: profile, info: info2),
                          ),
                        );
                      },
                      child: _buildInfoCard(info2),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(profile: profile, info: info3),
                          ),
                        );
                      },
                      child: _buildInfoCard(info3),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(profile: profile, info: info4),
                          ),
                        );
                      },
                      child: _buildInfoCard(info4),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(Map<String, dynamic> info) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 65,
            backgroundImage: NetworkImage(info['image']),
          ),
          SizedBox(height: 8.0),
          Text(
            info['name'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'EncodeSansCondensed',
            ),
          ),
        ],
      ),
    );
  }
}
