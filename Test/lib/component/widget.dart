import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test/details/Tv_detail.dart';
import 'package:test/details/movie_detail.dart';

class FullBoxWidget extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  FullBoxWidget({
    required this.name,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.25;
    double imageHeight = imageWidth * 1.50;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            if (image != '')
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  image,
                  height: imageHeight,
                  width: screenWidth,
                  fit: BoxFit.fitWidth,
                ),
              )
            else
              Container(
                height: imageHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.black,
              child: SizedBox(
                width: screenWidth,
                height: 60.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'EncodeSansCondensed',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductBoxWidget extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  ProductBoxWidget({
    required this.name,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.25;
    double imageHeight = imageWidth * 1.50;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            if (image != '')
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  image,
                  height: imageHeight,
                  width: imageWidth,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: imageHeight,
                width: imageWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.black,
              child: SizedBox(
                width: imageWidth,
                height: 60.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'EncodeSansCondensed',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
          // popularity: popularity,
          // vote_average: vote_average,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Automatically change page every 5 seconds
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
              return Padding( // Wrap FullBoxWidget with Padding
              padding: EdgeInsets.symmetric(horizontal: 8), // Adjust spacing as needed
              child: FullBoxWidget(
                name: movie['title'],
                image: 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
                onTap: () {
                  _onMovieTap(
                    movie['title'],
                    movie['overview'],
                    movie['backdrop_path'],
                    movie['id'],
                    movie['release_date'],
                    // movie['popularity'],
                    // movie['vote_average'],
                  );
                },
              ),
            );
          },
        ),
      ),
    ],
  );
}
}

class Top10TvWidget extends StatefulWidget {
  final List<dynamic>? topMovies;

  const Top10TvWidget({Key? key, this.topMovies}) : super(key: key);

  @override
  _Top10TVWidgetState createState() => _Top10TVWidgetState();
}

class _Top10TVWidgetState extends State<Top10TvWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  void _onMovieTap(String title, String overview, String? image, int id,
      String first_air_date) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TvDetailPage(
          original_name: title,
          overview: overview,
          image: image,
          id: id,
          first_air_date: first_air_date,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Automatically change page every 5 seconds
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
              return Padding( // Wrap FullBoxWidget with Padding
              padding: EdgeInsets.symmetric(horizontal: 8), // Adjust spacing as needed
              child: FullBoxWidget(
                name: movie['original_name'],
                image: 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
                onTap: () {
                  _onMovieTap(
                    movie['original_name'],
                    movie['overview'],
                    movie['backdrop_path'],
                    movie['id'],
                    movie['first_air_date'],
                  );
                },
              ),
            );
          },
        ),
      ),
    ],
  );
}
}
