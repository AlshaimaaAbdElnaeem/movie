import 'package:flutter/material.dart';

class PopularCard extends StatelessWidget {
  final Map<String, dynamic> movie;
  final List<Map<String, dynamic>> genres;
  final VoidCallback onTap;

  const PopularCard({
    required this.movie,
    required this.genres,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final genreIds = movie['genre_ids'];
    List<String> movieGenres = [];

    if (genreIds != null && genreIds.isNotEmpty) {
      for (var genreId in genreIds.take(2)) {
        var genre = genres.firstWhere(
          (g) => g['id'] == genreId,
          orElse: () => {'name': 'Unknown Genre'},
        );
        movieGenres.add(genre['name']);
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 14.0),
            width: 200,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: NetworkImage(
                  movie['poster_path'] != null
                      ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                      : 'https://placehold.co/600x400/EEE/31343C',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            movie['title'] ?? 'Unknown Title',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          Text(
            movieGenres.join(', '),
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}