import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  final String apiKey = 'd13121b031dcff9415c0f530448da400';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<dynamic>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<dynamic>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load popular movies');
    }
  }
    Future<List<dynamic>> getRandomMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&sort_by=popularity.desc'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load random movies');
    }
  }
    Future<List<dynamic>> getMoviesByLanguage(String language) async {
    String moviesByLanguageUrl = '$baseUrl/discover/movie?api_key=$apiKey&with_original_language=$language';
    final response = await http.get(Uri.parse(moviesByLanguageUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies by language');
    }
  }

  Future<List<dynamic>> getRandomTVShows() async {
    final response = await http.get(
      Uri.parse('$baseUrl/trending/tv/week?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> tvShows = data['results'];
      return tvShows;
    } else {
      throw Exception('Failed to load random TV shows');
    }
  }

  Future<List<dynamic>> getMoviesByGenre(String genreId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> movies = data['results'];
      return movies;
    } else {
      throw Exception('Failed to load movies by genre');
    }
  }Future<List<dynamic>> getTvByGenre(String genreId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/discover/tv?api_key=$apiKey&with_genres=$genreId'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> tvShows = data['results'];
      return tvShows;
    } else {
      throw Exception('Failed to load TV shows');
    }
  }

  Future<List<dynamic>> getnewMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> newMovies= data['results'];
      return newMovies;
    } else {
      throw Exception('Failed to load random TV shows');
    }
  }
  Future<List<dynamic>> getPopTv() async {
    final response = await http.get(
      Uri.parse('$baseUrl/tv/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> popTv= data['results'];
      return popTv;
    } else {
      throw Exception('Failed to load random TV shows');
    }
  }
  Future<List<dynamic>> getAiringTv() async {
    final response = await http.get(
      Uri.parse('$baseUrl/tv/airing_today?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> AiringTv= data['results'];
      return AiringTv;
    } else {
      throw Exception('Failed to load random TV shows');
    }
  }
  Future<List<dynamic>> getOntheairTv() async {
    final response = await http.get(
      Uri.parse('$baseUrl/tv/on_the_air?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> OntheairingTv= data['results'];
      return OntheairingTv;
    } else {
      throw Exception('Failed to load random TV shows');
    }
  }
}

