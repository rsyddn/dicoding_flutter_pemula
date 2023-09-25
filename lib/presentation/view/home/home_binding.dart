import 'package:dicoding_flutter_pemula_submission/data/repository/movie_repository.dart';
import 'package:dicoding_flutter_pemula_submission/data/source/movie_local.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => MovieLocal());
    Get.lazyPut(() => MovieRepository(Get.find()));
  }
}
