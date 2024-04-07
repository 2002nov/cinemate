import 'package:flutter/material.dart';
// import 'package:test/component/drawer.dart';
// import 'package:test/component/nav.dart';
import 'package:test/component/navdetail.dart';


class TvDetailPage extends StatefulWidget {
  final String original_name;
  final String overview;
  final String? image;
  final int id;
  final String first_air_date;

  TvDetailPage({
    required this.original_name,
    required this.overview,
    required this.image,
    required this.id, 
    required this.first_air_date,
  });

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  bool isAddedPressed = false;

  String extractYear(String dateString) {
    // Parse the date string
    DateTime date = DateTime.parse(dateString);
    // Extract the year
    String year = date.year.toString();
    return year;
  }

  @override
  Widget build(BuildContext context) {
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
                      Image.network(
                        'https://image.tmdb.org/t/p/w500${widget.image!}',
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
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
                      widget.original_name,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'EncodeSansCondensed',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Since ' + extractYear(widget.first_air_date),
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
                                setState(() {
                                  // Toggle the state of the button when pressed
                                  print('add TV shows');
                                  isAddedPressed = !isAddedPressed;
                                });
                                // Add your logic here for adding to favorite list
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                // Change background color to red when button is pressed
                                backgroundColor: isAddedPressed
                                    ? Colors.white
                                    : Colors.black,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                isAddedPressed ? 'TV show\ncannot be\nadded' : 'Add To List',
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
                          width: MediaQuery.of(context)
                              .size
                              .width, // Adjust width as needed
                          child: Row(
                            children: [
                              SizedBox(
                                  width:
                                      120), // Adjust width for the space between the icon button and text
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
                                    softWrap:
                                        true, // Enable automatic wrapping to new lines
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
}