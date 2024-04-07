import 'package:test/model/Movie.dart';

class MovieList {
  List<Movie> _movies = [];

  // Method to add a movie to the list
  void addMovie(Movie movie) {
    _movies.add(movie);
    print('add movie');
  }

  // Method to remove a movie from the list
  void removeMovie(Movie movie) {
    _movies.remove(movie);
    print('remove movie');
  }

  // Method to get the list of movies
  List<Movie> get movies => _movies;

  // bool contains(Movie movie) {
  //   return _movies.contains(movie);
  // }
}
