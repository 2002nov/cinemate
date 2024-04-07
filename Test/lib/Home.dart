import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test/component/drawer.dart';
import 'package:test/component/nav.dart';
import 'package:test/api/movie_service.dart';
import 'package:test/component/widget.dart';
import 'package:test/model/profile.dart';
import 'details/movie_detail.dart';

class Home extends StatefulWidget {
  final Map<String, dynamic> info;
  final Profile profile;

  const Home({
    Key? key,
    required this.profile,
    required this.info,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  final MovieService movieService = MovieService();
  late Future<List<dynamic>> randomMovies;
    late Future<List<dynamic>> ComedyMovies;
  late Future<List<dynamic>> DocMovies;
  late Future<List<dynamic>> TvMovies;

  @override
  void initState() {
    super.initState();
    randomMovies = movieService.getRandomMovies().then((movies) {
      movies.shuffle();
      return movies;
    });
    ComedyMovies = movieService.getMoviesByGenre('35');
    DocMovies = movieService.getMoviesByGenre('99');
    TvMovies = movieService.getMoviesByGenre('10770');
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
            FutureBuilder(
              future: randomMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List? movies = snapshot.data;

                  return Column(
                children: [
                  Align(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.transparent,
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movies?[3]['poster_path']}',
                                  width: double.infinity,
                                  height: 555,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                height: 555,
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
                            ],
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
                    Top10MoviesWidget(topMovies: movies),
                  ],
                );
              }
            },
          ),
            FutureBuilder(
              future: TvMovies,
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

                  return Column(
                    children: [
                    Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'TV Movies',
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
              future: DocMovies,
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

                return Column(
                    children: [
                    Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Documentary Movies',
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
              future: ComedyMovies,
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

                return Column(
                    children: [
                    Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Comedy Moives',
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
          ],
        ),
      ),
    );
  }
}

class Top10MoviesWidget extends StatefulWidget {
  final List<dynamic>? topMovies;

  const Top10MoviesWidget({Key? key, this.topMovies}) : super(key: key);

  @override
  _Top10MoviesWidgetState createState() => _Top10MoviesWidgetState();
}

class _Top10MoviesWidgetState extends State<Top10MoviesWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  void _onMovieTap(String title, String overview, String? image, int id ,String release_date) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(
          title: title,
          overview: overview,
          image: image,
          id: id, release_date: release_date,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < (widget.topMovies?.length ?? 0) - 1) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      } else {
        _pageController.jumpToPage(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Container(
          height: 240,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.topMovies?.length ?? 0,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              Map<String, dynamic> movie = widget.topMovies![index];
              return FullBoxWidget(
                name: movie['title'],
                image: 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
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
          ),
        ),
      ],
    );
  }
}

