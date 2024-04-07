class Movie {
  final String title;
  final String overview;
  final String? image;
  final int id;
  final String releaseDate;

  Movie({
    required this.title,
    required this.overview,
    required this.image,
    required this.id,
    required this.releaseDate,
  });

@override
  String toString() {
    return 'Movie(title: $title, overview: $overview, image: $image, id: $id, releaseDate: $releaseDate)';
  }
}
