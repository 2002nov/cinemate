import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/component/drawer.dart';
import 'package:test/component/nav.dart';
import 'package:test/setting.dart';
import 'package:test/model/profile.dart';

class Edit extends StatefulWidget {
  final Map<String, dynamic> info;
  final Profile profile;

  const Edit({
    Key? key,
    required this.profile,
    required this.info,
  }) : super(key: key);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return Scaffold(
      drawer: NavDrawer(profile: widget.profile, info: widget.info),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Bar(profile: widget.profile, info: widget.info),
        ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // "EDIT AS" text
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.topCenter,
              child: Text(
                'EDIT AS',
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
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: FutureBuilder<DocumentSnapshot>(
              future: users.doc(widget.profile.email).get(),
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
                            builder: (context) =>
                                Setting(profile: widget.profile, info: info1),
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
                            builder: (context) =>
                                Setting(profile: widget.profile, info: info2),
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
                            builder: (context) =>
                                Setting(profile: widget.profile, info: info3),
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
                            builder: (context) =>
                                Setting(profile: widget.profile, info: info4),
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
            radius: 65, // Increase the radius to match the larger container
            backgroundColor: Colors.transparent,
            child: Container(
              width: 160, // Increase the width of the container
              height: 160, // Increase the height of the container
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(info['image']),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Image.asset(
                'assets/editicon.png', // Path to your custom icon asset
                color: Colors.white, // You can add color if needed
                width: 120, // Adjust the width of the icon
                height: 120, // Adjust the height of the icon
              ),
            ),
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
