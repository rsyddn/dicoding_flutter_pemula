import 'package:dicoding_flutter_pemula_submission/data/mapper/movie_mapper.dart';
import 'package:dicoding_flutter_pemula_submission/data/model/genre_model.dart';
import 'package:dicoding_flutter_pemula_submission/data/model/movie_model.dart';
import 'package:dicoding_flutter_pemula_submission/data/source/movie_local.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/entity/movie.dart';

class MovieRepository {
  final MovieLocal local;

  MovieRepository(this.local);

  Future<List<Movie>> getNowPlayingMovie() async {
    final futureResults = await Future.wait([
      local.getNowPlayingMovie(),
      local.getGenres(),
    ]);
    final movieData = futureResults[0] as List<MovieModel>;
    final genreData = futureResults[1] as List<GenreModel>;

    return movieData
        .map((element) =>
            MovieMapper.mapModelToEntity(movie: element, genres: genreData))
        .toList();
  }

  Future<List<Movie>> getPopularMovie() async {
    final futureResults = await Future.wait([
      local.getPopularMovie(),
      local.getGenres(),
    ]);

    final movieData = futureResults[0] as List<MovieModel>;
    final genreData = futureResults[1] as List<GenreModel>;

    return movieData
        .map((element) =>
            MovieMapper.mapModelToEntity(movie: element, genres: genreData))
        .toList();
  }

  Future<List<Movie>> getTrendingMovie() async {
    final futureResults = await Future.wait([
      local.getTrendingMovie(),
      local.getGenres(),
    ]);

    final movieData = futureResults[0] as List<MovieModel>;
    final genreData = futureResults[1] as List<GenreModel>;

    return movieData
        .map((element) =>
            MovieMapper.mapModelToEntity(movie: element, genres: genreData))
        .toList();
  }

  Future<List<String>> getGenres() async {
    final genreData = await local.getGenres();
    return genreData.map((element) => element.name ?? "").toList();
  }

  Future<List<Movie>> getAllMovie() async {
    final futureResults = await Future.wait([
      local.getAllMovie(),
      local.getGenres(),
    ]);

    final movieData = futureResults[0] as List<MovieModel>;
    final genreData = futureResults[1] as List<GenreModel>;

    return movieData
        .map((element) =>
            MovieMapper.mapModelToEntity(movie: element, genres: genreData))
        .toList();
  }

  Future<Movie> getMovieDetail(int id) async {
    final futureResults = await Future.wait([
      local.getDetail(id),
      local.getGenres(),
    ]);

    final movieData = futureResults[0] as MovieModel;
    final genreData = futureResults[1] as List<GenreModel>;

    return MovieMapper.mapModelToEntity(movie: movieData, genres: genreData);
  }
}
