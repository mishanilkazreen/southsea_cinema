import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cinemaSurface,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.0,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.0,
              children: [
                Image.asset(
                  movie.imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.0,
                    children: [
                      // Movie Title and Age Rating
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: movie.name,
                              style: const TextStyle(
                                color: cinemaBrandDark,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' (${movie.ageRating})',
                              style: const TextStyle(
                                color: cinemaFontMuted,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Movie Description
                      Text(
                        movie.description,
                        style: const TextStyle(color: cinemaFontWhite),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Ticket Price
                Text(
                  '£${(movie.ticketPrice / 100).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: cinemaFontWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Book Now Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cinemaBrandDark,
                    foregroundColor: cinemaFontWhite,
                  ),
                  onPressed: () {},
                  child: const Text('BOOK NOW'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
