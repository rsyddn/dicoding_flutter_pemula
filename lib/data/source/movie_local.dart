import 'dart:convert';

import 'package:dicoding_flutter_pemula_submission/data/model/genre_model.dart';
import 'package:dicoding_flutter_pemula_submission/data/model/movie_model.dart';
import 'package:flutter/services.dart';

class MovieLocal {
  Future<List<MovieModel>> getPopularMovie() async {
    final String result =
        await rootBundle.loadString('asset/json/popular.json');
    final data = (jsonDecode(result) as List)
        .map((e) => MovieModel.fromJson(e))
        .toList();
    return data;
  }

  Future<List<MovieModel>> getTrendingMovie() async {
    final String result =
        await rootBundle.loadString('asset/json/trending.json');
    final data = (jsonDecode(result) as List)
        .map((e) => MovieModel.fromJson(e))
        .toList();
    return data;
  }

  Future<List<MovieModel>> getNowPlayingMovie() async {
    final String result =
        await rootBundle.loadString('asset/json/now_playing.json');
    final data = (jsonDecode(result) as List)
        .map((e) => MovieModel.fromJson(e))
        .toList();
    return data;
  }

  Future<List<GenreModel>> getGenres() async {
    final String result = await rootBundle.loadString('asset/json/genres.json');
    final data = (jsonDecode(result) as List)
        .map((e) => GenreModel.fromJson(e))
        .toList();
    return data;
  }

  Future<List<MovieModel>> getAllMovie() async {
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
    return mergedData;
  }

  Future<MovieModel> getDetail(int id) async {
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
    return mergedData.firstWhere((element) => element.id == id);
  }
}
