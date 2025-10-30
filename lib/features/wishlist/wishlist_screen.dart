import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/presentation/cubit/movie_details_cubit/movie_cubit.dart';
import 'package:movie/features/home/presentation/cubit/movie_details_cubit/movie_states.dart';
import 'package:movie/features/home/data/apis/get_list.dart';
import 'package:movie/features/home/data/models/movie_details/movie_details.dart';
import 'package:movie/features/home/presentation/movie_details.dart';

class MyWishList extends StatefulWidget {
  const MyWishList({super.key});

  @override
  State<MyWishList> createState() => _MyWishListState();
}

class _MyWishListState extends State<MyWishList> {
  final MoviesService _service = MoviesService();
  List<int> _ids = [];
  List<MovieDetailsModel> _movies = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
      final cubit = BlocProvider.of<MovieCubit>(context);
  if (cubit.wishlist.isEmpty) {
    cubit.loadWishlist();
  } else {
    _loadMoviesFromIds(cubit.wishlist);
  }
  }

  Future<void> _loadMoviesFromIds(List<int> ids) async {
    setState(() => _loading = true);
    _ids = List<int>.from(ids);

    try {
      final results = await Future.wait(
        ids.map((id) async {
          try {
            return await _service.fetchMovieDetails(id);
          } catch (_) {
            return null;
          }
        }),
      );

      _movies = results.whereType<MovieDetailsModel>().toList();
    } catch (e) {
      debugPrint('Error loading wishlist movies: $e');
    }

    if (!mounted) return;
    setState(() => _loading = false);
  }

  Future<void> _removeFromWishlist(int movieId) async {
    final cubit = BlocProvider.of<MovieCubit>(context);

    if (!mounted) return;
    setState(() {
      _movies.removeWhere((m) => m.id == movieId);
      _ids.remove(movieId);
    });

    cubit.toggleWishlist(movieId);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Removed from wishlist')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Wish List')),
      body: BlocListener<MovieCubit, MovieStates>(
        listener: (context, state) {
          if (state is MovieWishlistUpdatedState) {
            _loadMoviesFromIds(state.wishlist);
          }
        },
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _movies.isEmpty
                ? const Center(child: Text('No items in your wish list'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: _movies.length,
                    itemBuilder: (context, index) {
                      final movie = _movies[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MovieDetails(movieId: movie.id!),
                              ),
                            );
                          },
                          leading: movie.posterPath != null
                              ? Image.network(
                                  'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                  width: 50,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(width: 50),
                          title: Text(movie.title ?? 'Unknown Title'),
                          subtitle: Text(movie.releaseDate ?? ''),
                          trailing: IconButton(
                            icon:
                                const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () =>
                                _removeFromWishlist(movie.id!),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
