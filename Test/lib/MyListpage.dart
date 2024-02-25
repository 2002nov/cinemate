import 'package:flutter/material.dart';
import 'package:test/api/movie_service.dart'; // Import your MovieService or adjust as needed
import 'package:test/details/movie_detail.dart'; // Import your MovieDetailPage or adjust as needed
import 'package:test/model/profile.dart';
import 'component/drawer.dart';
import 'component/nav.dart';
import 'component/widget.dart';

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

  @override
  void initState() {
    super.initState();
    myList = movieService.getRandomMovies(); // Adjust this based on how you manage your "My List"
  }

  void _onMovieTap(String title, String overview, String? image, int id, String release_date) {
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
            Container(
              height: 200, // Set the height you desire
              width: double.infinity,
              child: Image.asset(
                'assets/profile.png', // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My List',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'EncodeSansCondensed',
                  ),
                ),
              ),
            ),SizedBox(height: 20,),
            FutureBuilder(
              future: myList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List? movies = snapshot.data;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.58,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: movies?.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> movie = movies?[index];
                      return ProductBoxWidget(
                        name: movie['title'],
                        image: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                        onTap: () {
                          _onMovieTap(
                            movie['title'],
                            movie['overview'],
                            movie['backdrop_path'],
                            movie['id'],
                            movie['release_date'],
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
