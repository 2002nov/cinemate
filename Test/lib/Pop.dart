import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test/api/movie_service.dart';
import 'package:test/component/widget.dart';
import 'package:test/details/Tv_detail.dart';
import 'package:test/details/movie_detail.dart';
import 'package:test/model/profile.dart';
import 'component/drawer.dart';
import 'component/nav.dart';


class Pop extends StatefulWidget {
  final Map<String, dynamic> info;
  final Profile profile;

  const Pop({
    Key? key,
    required this.profile,
    required this.info,
  }) : super(key: key);
  @override
  State<Pop> createState() => _HomeState();
}

class _HomeState extends State<Pop> {
final MovieService movieService = MovieService();
  late Future<List<dynamic>> popMovies;
  late Future<List<dynamic>> newMovies;
  late Future<List<dynamic>> popTv;
    late Future<List<dynamic>> AiringTv;
    late Future<List<dynamic>> OnairTv;

  @override
  void initState() {
    super.initState();
    popMovies = movieService.getPopularMovies();
    newMovies = movieService.getnewMovies();
    popTv = movieService.getPopTv();
    AiringTv = movieService.getAiringTv();
    OnairTv = movieService.getOntheairTv();
  }

  void _onMovieTap(String title, String overview, String? image, int id, String release_date) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TvDetailPage(
          original_name: title,
          overview: overview,
          image: image,
          id: id,
          first_air_date: release_date,
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
            FutureBuilder(
              future: popMovies,
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
                        'Top 10 Movie Rank',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'EncodeSansCondensed'),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Top10MoviesWidget(topMovies: movies,),
                  ],
                );
              }
            },
          ),
            FutureBuilder(
              future: newMovies,
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
                        'New On Cinemate',
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
              future: popTv,
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
                        'Top 10 Tv Show Rank',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'EncodeSansCondensed'),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),SizedBox(height: 20,),
                  Top10TvWidget(topMovies: movies,)
                    ],
                  );
                }
              },
            ),
            FutureBuilder(
              future: AiringTv,
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
                        'Coming This Week',
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
                            _onMovieTap(movie['original_name'], movie['overview'],
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
              future: OnairTv,
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
                        'Coming Next Week',
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
                            _onMovieTap(movie['original_name'], movie['overview'],
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
