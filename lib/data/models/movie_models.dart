class MovieModels {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;

  MovieModels({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
  });

  factory MovieModels.fromJson(Map<String, dynamic> json) {
    return MovieModels(
      title: json['Title'],
      year: json['Year'],
      imdbID: json['imdbID'],
      type: json['Type'],
      poster: json['Poster'],
    );
  }
}
