import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/api/movie_service.dart';
import 'package:test/details/movie_detail.dart';
import 'package:test/model/Movie.dart';
import 'package:test/model/profile.dart';
import 'component/drawer.dart';
import 'component/nav.dart';
import 'component/widget.dart';
import 'package:test/model/list.dart';

MovieList movieList = MovieList();

class MyListPage extends StatefulWidget {
  final Map<String, dynamic> info;
  final Profile profile;

  const MyListPage({
    Key? key,
    required this.profile,
    required this.info,
  }) : super(key: key);
  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  final MovieService movieService = MovieService();
  late Future<List<dynamic>> myList;
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  Future<void> fetchData() async {
    try {
      // Replace 'fav' with your collection name and 'email' with the actual email address
      var snapshot = await FirebaseFirestore.instance
          .collection('favorite_movies')
          .doc(widget.profile.email)
          .get();
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;

        // Iterate over each field (movie) and create a Movie object
        data.forEach((key, value) {
          var movieData = value as Map<String, dynamic>;
          var movie = Movie(
            id: movieData['id'],
            image: movieData['image'],
            overview: movieData['overview'],
            releaseDate: movieData['release_date'],
            title: movieData['title'],
          );
          movies.add(movie);
        });

        setState(() {});
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _onMovieTap(
    String title,
    String overview,
    String? image,
    int id,
    String release_date,
  ) {
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
    return Scaffold(
      drawer: NavDrawer(profile: widget.profile, info: widget.info),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Bar(profile: widget.profile, info: widget.info),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //profile image
            Stack(
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  child: Image.network(
                    widget.info['image'],
                    fit: BoxFit.cover, // Adjust the fit as needed
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
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            //text "My list"
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My List',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'EncodeSansCondensed',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Displaying movies
            Container(
              color: Colors.black, // White box color
              child: movies.isEmpty
                  ? Center(
                      child: Text(
                  'There is nothing on your list',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 20,
                    fontFamily: 'EncodeSansCondensed',
                  ),),
                    )
                  : movies.isNotEmpty
                      ?  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.58,
                    ),
                          shrinkWrap:
                              true, // Ensure the ListView doesn't take more space than necessary
                          physics:
                              NeverScrollableScrollPhysics(), // Disable scrolling of the ListView
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            var movie = movies[index];
                            return ProductBoxWidget(
                              name: movie.title,
                              image: 'https://image.tmdb.org/t/p/w500${movie.image}',
                              onTap: () {
                                _onMovieTap(
                                    movie.title,
                                    movie.overview,
                                    movie.image,
                                    movie.id,
                                    movie.releaseDate,
                                  );
                              },
                            );
                          },
                        )
                      : Center(
                          child: Text('No data'),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
