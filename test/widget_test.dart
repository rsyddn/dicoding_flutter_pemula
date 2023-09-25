import 'dart:convert';

import 'package:dicoding_flutter_pemula_submission/data/model/genre_model.dart';
import 'package:dicoding_flutter_pemula_submission/data/model/movie_model.dart';
import 'package:dicoding_flutter_pemula_submission/data/repository/movie_repository.dart';
import 'package:dicoding_flutter_pemula_submission/data/source/movie_local.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/entity/movie.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final MovieLocal localSource = MovieLocal();
  group("Get data from asset", () {
    testWidgets('Get data from asset/json/genres.json',
        (WidgetTester tester) async {
      final result = await localSource.getGenres();
      expect(result, everyElement(const TypeMatcher<GenreModel>()));
    });

    testWidgets('Get data from asset/json/now_playing.json',
        (WidgetTester tester) async {
      final result = await localSource.getNowPlayingMovie();
      expect(result, everyElement(const TypeMatcher<MovieModel>()));
    });

    testWidgets('Get data from asset/json/popular.json',
        (WidgetTester tester) async {
      final result = await localSource.getPopularMovie();
      expect(result, everyElement(const TypeMatcher<MovieModel>()));
    });

    testWidgets('Get data from asset/json/trending.json',
        (WidgetTester tester) async {
      final result = await localSource.getTrendingMovie();
      expect(result, everyElement(const TypeMatcher<MovieModel>()));
    });

    testWidgets('Get data from asset', (WidgetTester tester) async {
      final listResult = await Future.wait([
        rootBundle.loadString('asset/json/popular.json'),
        rootBundle.loadString('asset/json/trending.json'),
        rootBundle.loadString('asset/json/now_playing.json'),
      ]);

      final Set<int> addedIds = {};
      final List<MovieModel> mergedData = [];

      await Future.forEach(listResult, (jsonString) async {
        final jsonData = jsonDecode(jsonString) as List;

        for (var jsonMovie in jsonData) {
          final movie = MovieModel.fromJson(jsonMovie);
          if (!addedIds.contains(movie.id)) {
            mergedData.add(movie);
            addedIds.add(movie.id!);
          }
        }
      });

      expect(mergedData, everyElement(const TypeMatcher<MovieModel>()));
    });
  });

  group('Get data from local repositories', () {
    final MovieRepository repository = MovieRepository(localSource);
    testWidgets("Get now playing movie", (widgetTester) async {
      final result = await repository.getNowPlayingMovie();
      expect(result, everyElement(const TypeMatcher<Movie>()));
    });

    testWidgets("Get popular movie", (widgetTester) async {
      final result = await repository.getPopularMovie();
      expect(result, everyElement(const TypeMatcher<Movie>()));
    });

    testWidgets("Get trending movie", (widgetTester) async {
      final result = await repository.getTrendingMovie();
      expect(result, everyElement(const TypeMatcher<Movie>()));
    });
  });
}
