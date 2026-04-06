class MovieDetailsModels {
  final String title;
  final String year;
  final String rated;
  final String type;
  final String poster;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String actors;
  final String plot;
  final String language;

  MovieDetailsModels({
    required this.title,
    required this.year,
    required this.type,
    required this.rated,
    required this.poster,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.actors,
    required this.plot,
    required this.language,
  });

  factory MovieDetailsModels.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModels(
      title: json['Title'],
      year: json['Year'],
      rated: json['Rated'],
      type: json['Type'],
      poster: json['Poster'],
      released: json['Released'],
      runtime: json['Runtime'],
      genre: json['Genre'],
      director: json['Director'],
      actors: json['Actors'],
      plot: json['Plot'],
      language: json['Language'],
    );
  }
}
