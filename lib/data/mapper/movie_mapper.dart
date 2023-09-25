import 'package:dicoding_flutter_pemula_submission/data/model/genre_model.dart';
import 'package:dicoding_flutter_pemula_submission/data/model/movie_model.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/entity/movie.dart';

class MovieMapper {
  MovieMapper._();

  static Movie mapModelToEntity({
    required MovieModel movie,
    required List<GenreModel> genres,
  }) {
    return Movie(
      popularity: movie.popularity ?? 0.0,
      voteCount: movie.voteCount ?? 0,
      video: movie.video ?? false,
      posterPath: movie.posterPath ?? "",
      id: movie.id ?? 0,
      adult: movie.adult ?? false,
      backdropPath: movie.backdropPath ?? "",
      originalLanguage: movie.originalLanguage ?? "",
      originalTitle: movie.originalTitle ?? "",
      genres: genres
          .where((genre) => movie.genreIds!.contains(genre.id))
          .map((genreData) => genreData.name ?? "")
          .toList(),
      title: movie.title ?? "-",
      voteAverage: movie.voteAverage ?? 0,
      overview: movie.overview ?? "-",
      releaseDate: movie.releaseDate ?? "-",
    );
  }
}
