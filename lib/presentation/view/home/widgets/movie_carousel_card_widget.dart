import 'dart:math';

import 'package:dicoding_flutter_pemula_submission/data/constants.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/entity/movie.dart';
import 'package:flutter/material.dart';

class MovieCarouselCardWidget extends StatelessWidget {
  final Movie movie;

  const MovieCarouselCardWidget({super.key, required this.movie});

  // Generate a random color for genre chips
  Color _generateRandomColor() {
    final random = Random();
    final blueShades = [
      Colors.black45,
      Colors.black54,
      Colors.black87, // Darkest shade
    ];

    final selectedBlue = blueShades[random.nextInt(blueShades.length)];
    return selectedBlue; // Fallback to default Flutter blue
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double cardHeight = screenWidth * 0.75;

    // Adjust font sizes based on screen width
    final titleFontSize = screenWidth < 600 ? 16.0 : 20.0;
    final genreFontSize = screenWidth < 600 ? 10.0 : 12.0;
    final descriptionFontSize = screenWidth < 600 ? 12.0 : 14.0;

    // Adjust spacing for genre chips based on screen width
    final chipSpacing = screenWidth < 600 ? 2.0 : 5.0;

    return Card(
      semanticContainer: true,
      child: SizedBox(
        height: cardHeight,
        width: screenWidth,
        child: Stack(
          children: [
            SizedBox(
              width: screenWidth,
              height: cardHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "$IMAGE_URL${movie.backdropPath}",
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: cardHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: screenWidth < 600 ? 2 : 1, // Adjust maxLines
                  ),
                  Row(
                    children: [
                      Text(
                        "Rating: ",
                        style: TextStyle(
                          fontSize: descriptionFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: screenWidth < 600 ? 2 : 3, // Adjust maxLines
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        "${movie.voteAverage}",
                        style: TextStyle(
                          fontSize: descriptionFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: chipSpacing, // Adjust spacing
                    children: movie.genres.map((genre) {
                      final randomColor = _generateRandomColor();
                      return Chip(
                        label: Text(
                          genre,
                          style: TextStyle(
                            fontSize: genreFontSize,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: randomColor,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
