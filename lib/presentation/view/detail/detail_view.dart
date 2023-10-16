import 'dart:ui';

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

class _DetailViewState extends State<DetailView> with WidgetsBindingObserver {
  final controller = Get.find<DetailController>();
  late Orientation isPortrait;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  double width = 0.0;
  double height = 0.0;

  @override
  void didChangeMetrics() {
    setState(() {
      width = window.physicalSize.width;
      height = window.physicalSize.height;
      print("Width :${width}");
      print("Height :${height}");
    });
  }

  @override
  Widget build(BuildContext context) {
    isPortrait = MediaQuery.of(context).orientation;
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
    final chipSpacing = width < 600 ? 2.0 : 5.0;

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: width,
                    height: height,
                    child: Image.network(
                      "$IMAGE_URL${data.backdropPath}",
                      scale: 10,
                      fit: isPortrait == Orientation.portrait
                          ? BoxFit.fitHeight
                          : BoxFit.fitWidth,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  Container(
                    width: width,
                    height: height,
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
        Stack(
          children: [
            Container(
              height: height,
              margin: EdgeInsets.only(
                top: isPortrait == Orientation.portrait
                    ? height / 7
                    : height / 6,
                left: 16,
                right: 16,
                bottom: 16,
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
            ),
            Padding(
              padding: EdgeInsets.only(
                top: isPortrait == Orientation.portrait
                    ? height / 10
                    : height / 18,
                right: 32,
                left: 32,
              ),
              child: Column(
                children: [
                  Row(
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),
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
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
