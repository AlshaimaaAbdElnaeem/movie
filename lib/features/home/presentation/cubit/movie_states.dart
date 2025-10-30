import 'package:movie/features/home/data/models/movie_details/movie_details.dart';

abstract class MovieStates {}
class MovieInitialState extends MovieStates {}
class MovieLoadingState extends MovieStates {}  
class MovieSuccessState extends MovieStates {
  final MovieDetailsModel movieDetails;
  MovieSuccessState(this.movieDetails);
}
class MovieErrorState extends MovieStates {
  final String error;
  MovieErrorState(this.error);
}
class MovieWishlistUpdatedState extends MovieStates {
  final List<int> wishlist;
  MovieWishlistUpdatedState({required this.wishlist});
}
