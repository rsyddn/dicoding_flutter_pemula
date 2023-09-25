import 'package:dicoding_flutter_pemula_submission/presentation/routes/routes.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view/home/home_controller.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view/home/widgets/movie_card_loading_widget.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view/home/widgets/movie_card_widget.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view/home/widgets/movie_carousel_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: const Text("Dicoding Pemula"),
          backgroundColor: Colors.black87),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Now Playing",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: screenWidth * 0.5,
              child: Obx(
                () => controller.nowPlayingMovie.value.maybeWhen(
                  orElse: () => const LoadingWidget(),
                  success: (data) => PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    pageSnapping: true,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Get.offAndToNamed(
                        Routes.DETAIL,
                        arguments: data[index].id,
                      ),
                      child: MovieCarouselCardWidget(
                        movie: data[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Trending",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: screenWidth * 0.5,
              child: Obx(
                () => controller.trendingMovie.value.maybeWhen(
                  orElse: () => const LoadingWidget(),
                  success: (data) => PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    pageSnapping: true,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Get.offAndToNamed(
                        Routes.DETAIL,
                        arguments: data[index].id,
                      ),
                      child: MovieCarouselCardWidget(
                        movie: data[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Popular",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => controller.popularMovie.value.maybeWhen(
                orElse: () => const LoadingWidget(),
                success: (data) => ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Get.offAndToNamed(
                      Routes.DETAIL,
                      arguments: data[index].id,
                    ),
                    child: MovieCardWidget(
                      movie: data[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
        ],
      ),
    );
  }
}
