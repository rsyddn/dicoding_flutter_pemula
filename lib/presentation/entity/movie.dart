class Movie {
  final double popularity;
  final int voteCount;
  final bool video;
  final String posterPath;
  final int id;
  final bool adult;
  final String backdropPath;
  final String originalLanguage;
  final String originalTitle;
  final List<String> genres;
  final String title;
  final double voteAverage;
  final String overview;
  final String releaseDate;

  Movie({
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.posterPath,
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.genres,
    required this.title,
    required this.voteAverage,
    required this.overview,
    required this.releaseDate,
  });
}
