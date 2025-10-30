import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/features/home/presentation/cubit/movie_details_cubit/movie_cubit.dart';
import 'package:movie/features/home/presentation/cubit/movie_details_cubit/movie_states.dart';
import 'package:movie/features/home/presentation/cubit/tv_details_cubit/tv_cubit.dart';
import 'package:movie/features/home/presentation/cubit/tv_details_cubit/tv_states.dart';

class TvDetails extends StatefulWidget {
  const TvDetails({super.key, required this.tvId});
  final int tvId;

  @override
  State<TvDetails> createState() => _TvDetailsState();
}

class _TvDetailsState extends State<TvDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TvCubit()..fetchTvDetails(widget.tvId),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<TvCubit, TvStates>(
              builder: (context, state) {
                if (state is TvSuccessState) {
                  return BlocProvider(
                    create: (context) =>MovieCubit(),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              'https://image.tmdb.org/t/p/w500${state.tvDetails.posterPath ?? "https://placehold.co/600x400/EEE/31343C"}',
                              width: double.infinity,
                              height: 457.h,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 20.h,
                              left: 10.w,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 30.sp,
                                  color: Colors.white,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.tvDetails.name ?? 'Unknown Title',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  BlocBuilder<MovieCubit, MovieStates>(
                                    buildWhen: (previous, current) =>
                                        current is MovieWishlistUpdatedState,
                                    builder: (context, wishlistState) {
                                      final cubit = context.read<MovieCubit>();
                                      return IconButton(
                                        onPressed: () =>
                                            cubit.toggleWishlist(widget.tvId),
                                        icon: Icon(
                                          cubit.isInWishlist(widget.tvId)
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
                                state.tvDetails.genres!
                                    .map((genre) => genre.name)
                                    .join(', '),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                state.tvDetails.overview ??
                                    'No overview available.',
                                textAlign: TextAlign.start,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF706E6E),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              SizedBox(
                                height: 50.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomFinalData(
                                      text: state.tvDetails.languages!.join(
                                        ', ',
                                      ),
                                    ),
                                    CustomFinalData(
                                      text:
                                          '${state.tvDetails.episodeRunTime} Min',
                                    ),
                                    CustomFinalData(
                                      text: '${state.tvDetails.voteAverage} ⭐',
                                    ),
                                    CustomFinalData(
                                      text: state.tvDetails.numberOfSeasons
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is TvErrorState) {
                  return Center(child: Text('Error: ${state.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
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
