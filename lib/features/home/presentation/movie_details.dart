import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/features/home/presentation/cubit/movie_cubit.dart';
import 'package:movie/features/home/presentation/cubit/movie_states.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key, required this.movieId});
  final int movieId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit()..fetchProductDetails(movieId),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<MovieCubit, MovieStates>(
              builder: (context, state) {
                if (state is MovieSuccessState){
                  return  Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w500${state.movieDetails.posterPath}',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.movieDetails.title ?? 'Unknown Title',
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_outline,
                                  size: 33.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            state.movieDetails.genres!.map((genre) => genre.name).join(', '),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            state.movieDetails.overview ?? 'No overview available.',
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomFinalData(text: state.movieDetails.releaseDate!.substring(0, 4),),
                                CustomFinalData(text: '${state.movieDetails.runtime} Min',),
                                CustomFinalData(text: '${state.movieDetails.voteAverage} ⭐',),
                                CustomFinalData(text:state.movieDetails.runtime.toString(),),
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                );
           
                }else if (state is MovieErrorState){
                  return Center(child: Text('Error: ${state.error}'));
                }else {
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
  const CustomFinalData({
    super.key, required this.text,
  });
final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(
            top: 5.h,
            bottom: 5.h,
            right: 5.w,
          ),
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
