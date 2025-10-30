import 'package:movie/features/home/data/models/tv_details_model/tv_details_model.dart';

abstract class TvStates {}
class TvInitialState extends TvStates {}
class TvLoadingState extends TvStates {}  
class TvSuccessState extends TvStates {
  final TvDetailsModel tvDetails;
  TvSuccessState(this.tvDetails);
}
class TvErrorState extends TvStates {
  final String error;
  TvErrorState(this.error);
}