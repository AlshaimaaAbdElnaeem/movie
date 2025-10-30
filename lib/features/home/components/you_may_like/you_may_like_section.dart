import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/components/you_may_like/you_may_like_card.dart';
import 'package:movie/features/home/data/apis/get_list.dart';
import 'package:movie/features/home/presentation/cubit/movie_details_cubit/movie_cubit.dart';
import 'package:movie/features/home/presentation/movie_details.dart';

class YouMayLikeSection extends StatefulWidget {
  const YouMayLikeSection({super.key});

  @override
  State<YouMayLikeSection> createState() => _YouMayLikeSectionState();
}

class _YouMayLikeSectionState extends State<YouMayLikeSection> {
  MoviesService moviesService = MoviesService();
  List<Map<String, dynamic>> genres = [];

  @override
  void initState() {
    super.initState();
    moviesService.fetchGenres().then((data) {
      setState(() {
        genres = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder<List>(
            future: moviesService.fetchMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No movies found'));
              } else {
                return Row(
                  children: snapshot.data!.map<Widget>((movie) {
                    List<String> categories = _getCategories(
                      movie['genre_ids'],
                    );

                    return YouMayLikeCard(
                      title: movie['title'] ?? 'Unknown Title',
                      categories: categories,
                      imageUrl: movie['poster_path'] != null
                          ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                          : 'https://placehold.co/600x400/EEE/31343C',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                // MyDetailsPage(movieId: movie['id']),
                                BlocProvider(
                                  create: (context) => MovieCubit(),
                                  child: MovieDetails(movieId: movie['id']),
                                ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  List<String> _getCategories(List<dynamic> genreIds) {
    List<String> categories = [];

    for (var genreId in genreIds.take(2)) {
      var genre = genres.firstWhere(
        (g) => g['id'] == genreId,
        orElse: () => {'name': 'Unknown Category'},
      );
      categories.add(genre['name']);
    }

    return categories;
  }
}
