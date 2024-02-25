import 'package:flutter/material.dart';
import 'package:test/component/drawer.dart';
import 'package:test/component/nav.dart';
import 'package:http/http.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class MovieDetailPage extends StatefulWidget {
  final String title;
  final String overview;
  final String? image;
  final int id;
  final String release_date;

  MovieDetailPage({
    required this.title,
    required this.overview,
    required this.image,
    required this.id, 
    required this.release_date,
  });

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: Bar(),
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
                    if (widget.image != null)
                      Image.network(
                        'https://image.tmdb.org/t/p/w500${widget.image!}',
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(height: 16),
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.release_date,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Overview:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        widget.overview,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        label: Text('Go Back'),
        icon: Icon(Icons.arrow_back),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
