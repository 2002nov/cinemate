import 'package:flutter/material.dart';
import 'package:test/component/drawer.dart';
import 'package:test/component/nav.dart';


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
                      widget.original_name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.first_air_date,
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
