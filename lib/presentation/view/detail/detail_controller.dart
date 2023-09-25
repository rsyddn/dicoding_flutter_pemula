import 'package:dicoding_flutter_pemula_submission/data/repository/movie_repository.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/entity/movie.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view_state/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final repository = Get.find<MovieRepository>();
  final movieId = Get.arguments as int;
  late ScrollController scrollController = ScrollController();
  Rx<ViewState<Movie>> data = const ViewState<Movie>.initial().obs;

  @override
  void onInit() async {
    super.onInit();
    initialScrollController();
    getDetailData();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void initialScrollController() {
    scrollController.addListener(() {});
  }

  void getDetailData() async {
    data.value = const ViewState<Movie>.loading();
    final result = await repository.getMovieDetail(movieId);
    data.value = ViewState.success(data: result);
  }
}
