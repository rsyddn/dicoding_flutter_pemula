import 'package:dicoding_flutter_pemula_submission/data/constants.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/entity/movie.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/routes/routes.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/view/detail/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final controller = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // Set the background color to transparent
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Get.offNamed(Routes.HOME),
        ),
      ),
      body: Obx(() {
        return controller.data.value.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          success: (data) => success(data, context),
          failed: (message) => const Center(
            child: Text("Failed To Load Data"),
          ),
        );
      }),
    );
  }

  Widget success(Movie data, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Adjust font sizes based on screen width
    final chipSpacing = screenWidth < 600 ? 2.0 : 5.0;

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight,
                    child: Image.network(
                      "$IMAGE_URL${data.backdropPath}",
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  Container(
                    width: screenWidth,
                    height: screenHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black87.withOpacity(0.5),
                          Colors.black87.withOpacity(1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black,
              ),
            ),
          ],
        ),
        SafeArea(
          child: Stack(
            children: [
              Container(
                height: screenHeight,
                margin: EdgeInsets.only(
                  top: screenHeight / 6,
                  left: 8,
                  right: 8,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset:
                          const Offset(0, 3), // Offset (horizontal, vertical)
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(
                  top: 32,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      spacing: chipSpacing, // Adjust spacing
                      children: data.genres.map((genre) {
                        return Chip(
                          label: Text(
                            genre,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.black87,
                        );
                      }).toList(),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Release At:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('d MMMM y')
                              .format(DateTime.parse(data.releaseDate)),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        const Text(
                          'Rates:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${data.voteAverage}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data.overview,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 100,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 30,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          "$IMAGE_URL${data.posterPath}",
                          fit: BoxFit.fitHeight,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        data.title,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
