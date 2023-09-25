import 'package:dicoding_flutter_pemula_submission/presentation/routes/routes.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view/detail/detail_binding.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view/detail/detail_view.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view/home/home_binding.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view/home/home_view.dart';
import 'package:get/get.dart';

class Pages {
  Pages._();

  static const INITIAL = Routes.HOME;
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      transition: Transition.rightToLeftWithFade,
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => const DetailView(),
      transition: Transition.rightToLeftWithFade,
      binding: DetailBinding(),
    ),
  ];
}
