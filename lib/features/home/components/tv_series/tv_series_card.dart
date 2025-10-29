import 'package:flutter/material.dart';

class TvSeriesCard extends StatelessWidget {
  final Map<String, dynamic> tvSeries;
  final List<Map<String, dynamic>> genres;
  final VoidCallback onTap;

  const TvSeriesCard({
    required this.tvSeries,
    required this.genres,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final genreIds = tvSeries['genre_ids'];
    List<String> tvSeriesGenres = [];

    if (genreIds != null && genreIds.isNotEmpty) {
      for (var genreId in genreIds.take(2)) {
        var genre = genres.firstWhere(
          (g) => g['id'] == genreId,
          orElse: () => {'name': 'Unknown Genre'},
        );
        tvSeriesGenres.add(genre['name']);
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 14.0),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: NetworkImage(
                  tvSeries['poster_path'] != null
                      ? 'https://image.tmdb.org/t/p/w500${tvSeries['poster_path']}'
                      : 'https://placehold.co/600x400/EEE/31343C',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
            child: Text(
              tvSeries['name'] ?? 'Unknown Title',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            tvSeriesGenres.join(', '),
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
