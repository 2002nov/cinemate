import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test/api/movie_service.dart';
import 'package:test/details/movie_detail.dart';
import 'component/drawer.dart';
import 'component/nav.dart';
import 'component/widget.dart';


class Moviepage extends StatefulWidget {
  @override
  State<Moviepage> createState() => _MovieState();
}


class _MovieState extends State<Moviepage> {
final MovieService movieService = MovieService();
  late Future<List<dynamic>> randomMovies;
  late Future<List<dynamic>> ActionMovies;
  late Future<List<dynamic>> DramaMovies;
  late Future<List<dynamic>> AnimateMovies;
  

  @override
  void initState() {
    super.initState();
    randomMovies = movieService.getRandomMovies().then((movies) {
      movies.shuffle();
      return movies;
    });
    ActionMovies = movieService.getMoviesByGenre('28');
    DramaMovies = movieService.getMoviesByGenre('18');
    AnimateMovies = movieService.getMoviesByGenre('16');


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
      drawer: NavDrawer(),
      appBar: Bar(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: randomMovies,
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

                  // Return the widget tree for randomMovies
                  return Column(
                children: [
                  Align(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.transparent,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movies?[3]['poster_path']}',
                          width: double.infinity,
                          height: 475,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Perfect Tonight',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'EncodeSansCondensed'),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 238,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies?.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> movie = movies?[index];
                        return ProductBoxWidget(
                          name: movie['title'],
                          image:
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          onTap: () {
                            _onMovieTap(movie['title'], movie['overview'],
                                movie['backdrop_path'], movie['id'],movie['release_date']);
                          },
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Continue Watching',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'EncodeSansCondensed'),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies?.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> movie = movies?[index];
                        return ProductBoxWidget(
                          name: movie['title'],
                          image:
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          onTap: () {
                            _onMovieTap(movie['title'], movie['overview'],
                                movie['backdrop_path'], movie['id'],movie['release_date']);
                            },
                          );
                        },
                      ),
                    ),
                    Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Top 10',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'EncodeSansCondensed'),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                    SizedBox(height: 20,),
                    Top10MoviesWidget(topMovies: movies),
                  ],
                );
              }
            },
          ),
            FutureBuilder(
              future: DramaMovies,
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

                  // Return the widget tree for actionMovies
                  return Column(
                    children: [
                     Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Drama',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'EncodeSansCondensed'),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies?.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> movie = movies?[index];
                        return ProductBoxWidget(
                          name: movie['title'],
                          image:
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          onTap: () {
                            _onMovieTap(movie['title'], movie['overview'],
                                movie['backdrop_path'], movie['id'],movie['release_date']);
                          },
                        );
                      },
                    ),
                  ),
                    ],
                  );
                }
              },
            ),
            FutureBuilder(
              future: ActionMovies,
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

                  // Return the widget tree for actionMovies
                 return Column(
                    children: [
                     Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Action',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'EncodeSansCondensed'),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Container(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies?.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> movie = movies?[index];
                        return ProductBoxWidget(
                          name: movie['title'],
                          image:
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          onTap: () {
                            _onMovieTap(movie['title'], movie['overview'],
                                movie['backdrop_path'], movie['id'],movie['release_date']);
                          },
                        );
                      },
                    ),
                  ),
                    ],
                  );
                }
              },
            ),
            FutureBuilder(
              future: AnimateMovies,
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

                  // Return the widget tree for actionMovies
                 return Column(
                    children: [
                     Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Animations',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'EncodeSansCondensed'),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Container(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies?.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> movie = movies?[index];
                        return ProductBoxWidget(
                          name: movie['title'],
                          image:
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          onTap: () {
                            _onMovieTap(movie['title'], movie['overview'],
                                movie['backdrop_path'], movie['id'],movie['release_date']);
                          },
                        );
                      },
                    ),
                  ),
                    ],
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

