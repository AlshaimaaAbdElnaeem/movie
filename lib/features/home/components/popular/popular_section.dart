import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/components/popular/popular_card.dart';
import 'package:movie/features/home/data/apis/get_list.dart';
import 'package:movie/features/home/presentation/cubit/movie_details_cubit/movie_cubit.dart';
import 'package:movie/features/home/presentation/movie_details.dart';

class PopularSection extends StatefulWidget {
  const PopularSection({super.key});

  @override
  State<PopularSection> createState() => _PopularSectionState();
}

class _PopularSectionState extends State<PopularSection> {
  final MoviesService popularMoviesService = MoviesService();
  List<Map<String, dynamic>> genres = [];

  @override
  void initState() {
    super.initState();
    popularMoviesService.fetchGenres().then((data) {
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
            future: popularMoviesService.fetchMovies(),
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
                    return PopularCard(
                      movie: movie,
                      genres: genres,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                // MovieDetailPage(movieId: movie['id']),
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
}
