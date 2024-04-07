import 'package:flutter/material.dart';
import 'package:test/api/movie_service.dart';
import 'package:test/component/drawer.dart';
import 'package:test/details/movie_detail.dart';
import 'package:test/component/nav.dart';
import 'package:test/component/widget.dart';
import 'package:test/model/profile.dart';

class Lang extends StatefulWidget {
  final Map<String, dynamic> info;
  final Profile profile;

  const Lang({
    Key? key,
    required this.profile,
    required this.info,
  }) : super(key: key);
  @override
  _LanguageBasedMoviePageState createState() => _LanguageBasedMoviePageState();
}

class _LanguageBasedMoviePageState extends State<Lang> {
  final MovieService movieService = MovieService();
  late Future<List<dynamic>> movies;
  String selectedLanguage = 'en'; // Default language is English

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

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

  Future<void> loadMovies() async {
    setState(() {
      movies = movieService.getMoviesByLanguage(selectedLanguage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(profile: widget.profile, info: widget.info),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Bar(profile: widget.profile, info: widget.info),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Text and language selection in the same line
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Select Language:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                    fontFamily: 'EncodeSansCondensed',
                  ),
                ),
                SizedBox(width: 20), // Add some space between text and dropdown
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Dropdown background color
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    dropdownColor: Colors.black,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedLanguage = newValue;
                          loadMovies();
                        });
                      }
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ), // Set the selection box color
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text(
                          'English',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'EncodeSansCondensed',
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'es',
                        child: Text(
                          'Spanish',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'EncodeSansCondensed',
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'th',
                        child: Text(
                          'Thai',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'EncodeSansCondensed',
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'ja',
                        child: Text(
                          'Japanese',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'EncodeSansCondensed',
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'cn',
                        child: Text(
                          'Chinese',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'EncodeSansCondensed',
                          ),
                        ),
                      ),
                      // Add more language options as needed
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Movie list
          Expanded(
            child: FutureBuilder(
              future: movies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List? movieList = snapshot.data;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.57,
                    ),
                    itemCount: movieList?.length ?? 0,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> movie = movieList![index];
                      return ProductBoxWidget(
                        name: movie['title'],
                        image:
                            'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                        onTap: () {
                          _onMovieTap(
                              movie['title'],
                              movie['overview'],
                              movie['backdrop_path'],
                              movie['id'],
                              movie['release_date']);
                        },
                        // Add more details as needed
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
