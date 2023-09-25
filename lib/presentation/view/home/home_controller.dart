import 'package:dicoding_flutter_pemula_submission/data/repository/movie_repository.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/entity/movie.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view_state/view_state.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final repository = Get.find<MovieRepository>();
  Rx<ViewState<List<Movie>>> popularMovie =
      const ViewState<List<Movie>>.initial().obs;
  Rx<ViewState<List<Movie>>> trendingMovie =
      const ViewState<List<Movie>>.initial().obs;
  Rx<ViewState<List<Movie>>> nowPlayingMovie =
      const ViewState<List<Movie>>.initial().obs;

  @override
  void onInit() async {
    super.onInit();
    await getPopularMovie();
    await getTrendingMovie();
    await getNowPlayingMovie();
  }

  Future<void> getPopularMovie() async {
    popularMovie.value = const ViewState<List<Movie>>.loading();
    final result = await repository.getPopularMovie();
    popularMovie.value = ViewState<List<Movie>>.success(data: result);
  }

  Future<void> getTrendingMovie() async {
    trendingMovie.value = const ViewState<List<Movie>>.loading();
    final result = await repository.getTrendingMovie();
    trendingMovie.value = ViewState<List<Movie>>.success(data: result);
  }

  Future<void> getNowPlayingMovie() async {
    nowPlayingMovie.value = const ViewState<List<Movie>>.loading();
    final result = await repository.getNowPlayingMovie();
    nowPlayingMovie.value = ViewState<List<Movie>>.success(data: result);
  }
}
