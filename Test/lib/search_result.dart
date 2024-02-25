import 'package:flutter/material.dart';
import 'package:test/component/drawer.dart';
import 'package:test/component/nav.dart';
import 'package:test/api/movie_service.dart';
import 'package:test/component/widget.dart';
import 'package:test/model/profile.dart';
import 'details/movie_detail.dart';

class SecondPage extends StatefulWidget {
  final String searchQuery;
  final Map<String, dynamic> info;
  final Profile profile;

  // Corrected constructor definition
  const SecondPage({
    Key? key,
    required this.searchQuery,
    required this.profile,
    required this.info,
  }) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final MovieService _movieService = MovieService();
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    _searchMovies();
  }

  Future<void> _searchMovies() async {
    try {
      final List<dynamic> result =
          await _movieService.searchMovies(widget.searchQuery);
      setState(() {
        movies = result;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  // Function to handle movie tap
  void _onMovieTap(String title, String overview, String? image, int id,
      String release_date) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(
          title: title,
          overview: overview,
          image: image,
          id: id,
          release_date: release_date,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CINEMATE",
      home: Scaffold(
        drawer: NavDrawer(profile: widget.profile, info: widget.info),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Bar(profile: widget.profile, info: widget.info),
        ),
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Result for: ${widget.searchQuery}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'EncodeSansCondensed',
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.57,
                children: List.generate(movies.length, (index) {
                  final item = movies[index];
                  print(item['title']);
                  if (item['poster_path'] != null) {
                    return ProductBoxWidget(
                      name: item['title'],
                      image:
                          'https://image.tmdb.org/t/p/w500/${item['poster_path']}',
                      onTap: () {
                        _onMovieTap(
                            item['title'],
                            item['overview'],
                            item['backdrop_path'],
                            item['id'],
                            item['release_date']);
                      },
                    );
                  } else {
                    return ProductBoxWidget(
                      name: item['title'],
                      image: '',
                      onTap: () {
                        _onMovieTap(item['title'], item['overview'],
                            item['image'], item['id'], item['release_date']);
                      },
                    ); // Empty container for items without an image
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
