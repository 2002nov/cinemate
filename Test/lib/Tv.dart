import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test/details/Tv_detail.dart';
import 'package:test/component/drawer.dart';
import 'package:test/component/nav.dart';
import 'package:test/api/movie_service.dart';
import 'package:test/component/widget.dart';
import 'details/movie_detail.dart';


class Tv extends StatefulWidget {
  @override
  State<Tv> createState() => _TvState();
}

class _TvState extends State<Tv> {
final MovieService movieService = MovieService();
  late Future<List<dynamic>> RandomTVShows;
  late Future<List<dynamic>> FamilyTVShows;
  late Future<List<dynamic>> KidTVShows;
  late Future<List<dynamic>> RealityTVShows;
  

  @override
  void initState() {
    super.initState();
    RandomTVShows = movieService.getRandomTVShows().then((tvShows) {
      tvShows.shuffle();
      return tvShows;
    });
    FamilyTVShows = movieService.getTvByGenre('10751');
    KidTVShows = movieService.getTvByGenre('10762');
    RealityTVShows = movieService.getTvByGenre('10764');
  }

  void _onTvTap(String original_name, String overview, String? image, int id, String first_air_date) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TvDetailPage(
          original_name: original_name,
          overview: overview,
          image: image,
          id: id,
          first_air_date: first_air_date,
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
              future: RandomTVShows,
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
                          name: movie['original_name'],
                          image:
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          onTap: () {
                            _onTvTap(movie['original_name'], movie['overview'],
                                movie['backdrop_path'], movie['id'],movie['first_air_date']);
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
                          name: movie['original_name'],
                          image:
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          onTap: () {
                            _onTvTap(movie['original_name'], movie['overview'],
                                movie['backdrop_path'], movie['id'],movie['first_air_date']);
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
                        'Top 10 ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'EncodeSansCondensed'),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),SizedBox(height: 20,),
                    Top10TvWidget(topMovies: movies),
                  ],
                );
              }
            },
          ),
            FutureBuilder(
              future: FamilyTVShows,
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
                        'Family TV Show',
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
                          name: movie['original_name'],
                          image:
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          onTap: () {
                            _onTvTap(movie['original_name'], movie['overview'],
                                movie['backdrop_path'], movie['id'],movie['first_air_date']);
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
              future: KidTVShows,
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
                        'Kids TV Show',
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
                          name: movie['original_name'],
                          image:
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          onTap: () {
                            _onTvTap(movie['original_name'], movie['overview'],
                                movie['backdrop_path'], movie['id'],movie['first_air_date']);
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
              future: RealityTVShows,
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
                        'Reality TV Show',
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
                          name: movie['original_name'],
                          image:
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          onTap: () {
                            _onTvTap(movie['original_name'], movie['overview'],
                                movie['backdrop_path'], movie['id'],movie['first_air_date']);
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


