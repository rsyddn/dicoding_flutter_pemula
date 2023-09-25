import 'package:dicoding_flutter_pemula_submission/data/repository/movie_repository.dart';
import 'package:dicoding_flutter_pemula_submission/data/source/movie_local.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view/detail/detail_controller.dart';
import 'package:get/get.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailController());
    Get.lazyPut(() => MovieLocal());
    Get.lazyPut(() => MovieRepository(Get.find()));
  }
}
