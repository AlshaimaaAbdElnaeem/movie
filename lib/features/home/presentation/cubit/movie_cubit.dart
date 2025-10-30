import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/data/apis/get_list.dart';
import 'package:movie/features/home/presentation/cubit/movie_states.dart';

class MovieCubit extends Cubit<MovieStates>{
  MoviesService moviesService = MoviesService();
  MovieCubit() : super(MovieInitialState());
  fetchProductDetails(int id)async{
    emit(MovieLoadingState());
    moviesService.fetchMovieDetails(id).then((movies){
      emit(MovieSuccessState(movies));
    }).catchError((error){
      emit(MovieErrorState(error.toString()));
    });
}}