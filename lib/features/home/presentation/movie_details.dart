import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/features/home/data/models/movie_details/movie_details.dart';
import 'package:movie/features/home/presentation/cubit/movie_details_cubit/movie_cubit.dart';
import 'package:movie/features/home/presentation/cubit/movie_details_cubit/movie_states.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.movieId});
  final int movieId;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  MovieDetailsModel? _cachedDetails;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = BlocProvider.of<MovieCubit>(context);
      cubit.fetchMovieDetails(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MovieCubit>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:BlocBuilder<MovieCubit, MovieStates>(
  buildWhen: (previous, current) =>
      current is MovieSuccessState || current is MovieErrorState,
  builder: (context, state) {
    if (state is MovieSuccessState) {
      _cachedDetails = state.movieDetails;
      final details = state.movieDetails;

      return Column(
        children: [
          Stack(
            children: [
              Image.network(
                'https://image.tmdb.org/t/p/w500${details.posterPath}',
                width: double.infinity,
                height: 457.h,
                fit: BoxFit.fill,
              ),
              Positioned(
                top: 20.h,
                left: 10.w,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30.sp,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 36.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        details.title ?? 'Unknown Title',
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BlocBuilder<MovieCubit, MovieStates>(
                      buildWhen: (previous, current) =>
                          current is MovieWishlistUpdatedState,
                      builder: (context, wishlistState) {
                        final cubit = context.read<MovieCubit>();
                        return IconButton(
                          onPressed: () =>
                              cubit.toggleWishlist(widget.movieId),
                          icon: Icon(
                            cubit.isInWishlist(widget.movieId)
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            size: 33.sp,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  details.genres!.map((genre) => genre.name).join(', '),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  details.overview ?? 'No overview available.',
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF706E6E),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomFinalData(
                        text: details.releaseDate!.substring(0, 4),
                      ),
                      CustomFinalData(text: '${details.runtime} Min'),
                      CustomFinalData(
                        text: '${details.voteAverage} ⭐',
                      ),
                      CustomFinalData(
                        text: details.runtime.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (state is MovieErrorState) {
      return Center(child: Text(state.error));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  },
),
        ),
      ),
    );
  }
}

class CustomFinalData extends StatelessWidget {
  const CustomFinalData({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.h, bottom: 5.h, right: 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}