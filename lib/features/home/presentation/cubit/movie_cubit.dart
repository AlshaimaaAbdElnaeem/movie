import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/data/apis/get_list.dart';
import 'package:movie/features/home/presentation/cubit/movie_states.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 👈 جديد

class MovieCubit extends Cubit<MovieStates>{
  MoviesService moviesService = MoviesService();
  
  MovieCubit() : super(MovieInitialState()){
    loadWishlist(); // تحميل المفضلة عند إنشاء الكيوبت
  }

  List<int> wishlist = []; // 👈 قائمة المفضلة

  fetchProductDetails(int id) async {
    emit(MovieLoadingState());
    moviesService.fetchMovieDetails(id).then((movies){
      emit(MovieSuccessState(movies));
    }).catchError((error){
      emit(MovieErrorState(error.toString()));
    });
  }

  // 👇 تحميل wishlist من SharedPreferences
  Future<void> loadWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    wishlist = prefs.getStringList('wishlist')?.map((e) => int.parse(e)).toList() ?? [];
    emit(MovieWishlistUpdatedState(wishlist: wishlist));
  }

  // 👇 إضافة/إزالة فيلم من wishlist
  Future<void> toggleWishlist(int movieId) async {
    if (wishlist.contains(movieId)) {
      wishlist.remove(movieId);
    } else {
      wishlist.add(movieId);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('wishlist', wishlist.map((e) => e.toString()).toList());
    emit(MovieWishlistUpdatedState(wishlist: wishlist));
  }

  // 👇 التحقق إذا الفيلم موجود في المفضلة
  bool isInWishlist(int movieId) {
    return wishlist.contains(movieId);
  }
}
