import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/data/apis/get_list.dart';
import 'package:movie/features/home/presentation/cubit/tv_details_cubit/tv_states.dart';

class TvCubit extends Cubit<TvStates>{
  TvCubit() : super(TvInitialState());
MoviesService tvsService = MoviesService();
  fetchTvDetails(int id)async{
    emit(TvLoadingState());
    tvsService.fetchTvDetails(id).then((tvs){
      emit(TvSuccessState(tvs));

    }).catchError((error){
      emit(TvErrorState(error.toString()));
    });
}}