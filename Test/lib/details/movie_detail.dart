import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/component/navdetail.dart';
import 'package:test/model/Movie.dart';
import 'package:test/main.dart';
import 'package:test/model/list.dart';
import '../component/login_component.dart';

class MovieDetailPage extends StatefulWidget {
  final String title;
  final String overview;
  final String? image;
  final int id;
  final String release_date;

  const MovieDetailPage({
    required this.title,
    required this.overview,
    required this.image,
    required this.id,
    required this.release_date,
  });

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}


class MovieAddedPressedProvider extends ChangeNotifier {
  Map<int, bool> _addedStatus = {};

  bool isAddedPressed(int id) {
    return _addedStatus[id] ?? false;
  }

  void setAddedPressed(int id, bool value) {
    _addedStatus[id] = value;
    notifyListeners();
  }
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final addedPressedProvider =
        Provider.of<MovieAddedPressedProvider>(context);
    final isAddedPressed = addedPressedProvider.isAddedPressed(widget.id);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Nav(),
      ),
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        if (widget.image != null)
                          Container(
                            height: 350,
                            width: double.infinity,
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${widget.image!}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        Container(
                          height: 350,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.transparent,
                                Colors.black.withOpacity(0.9),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 15,
                          right: 0,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.play_arrow_sharp, size: 55),
                                color: Colors.black,
                                onPressed: () {
                                  print('play button is pressed');
                                  // Navigate to play movie
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'EncodeSansCondensed',
                      ),
                    ),
                    SizedBox(height: 10),
                    //display year
                    Text(
                      'Since ' + extractYear(widget.release_date),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'EncodeSansCondensed',
                      ),
                    ),
                    SizedBox(height: 15),
                    Stack(
                      children: [
                        Positioned(
                          child: Container(
                            child: ElevatedButton(
                              onPressed: () {
                                addedPressedProvider.setAddedPressed(
                                    widget.id, !isAddedPressed);
                                setState(() {}); // Update the UI immediately
                                if (!isAddedPressed) {
                                  _addToFavoriteList();
                                } else {
                                  _removeFromFavoriteList(widget.title);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: isAddedPressed
                                    ? Colors.white
                                    : Colors.black,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                              ),
                              child: Text(
                                isAddedPressed ? 'Added' : 'Add To List',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: isAddedPressed
                                      ? Colors.black
                                      : Colors.white,
                                  fontFamily: 'EncodeSansCondensed',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              SizedBox(width: 120),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    widget.overview,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'EncodeSansCondensed',
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String extractYear(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return date.year.toString();
  }

  void _addToFavoriteList() {
    FirebaseFirestore.instance
        .collection('favorite_movies')
        .doc(profile.email)
        // .collection(profile.email)
        // .doc(Info['name'])
        .set({
      widget.title: {
        'title': widget.title,
        'overview': widget.overview,
        'image': widget.image,
        'id': widget.id,
        'release_date': widget.release_date,
      }
    }, SetOptions(merge: true)).then((_) {
      print('Favorite movie is added to Firebase');
    }).catchError((error) {
      print(error);
    });
  }

  void _removeFromFavoriteList(String movieTitle) {
    FirebaseFirestore.instance
        .collection('favorite_movies')
        .doc(profile.email)
        .update({
      movieTitle: FieldValue.delete(),
    }).then((_) {
      print('Favorite movie removed from Firebase');
    }).catchError((error) {
      print(error);
    });
  }
}
