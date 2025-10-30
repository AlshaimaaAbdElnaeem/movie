import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/features/home/data/models/movie_details/movie_details.dart';
import 'package:movie/features/home/data/models/tv_details_model/tv_details_model.dart';

class MoviesService {
 static const String apiUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=29cf44b93ca83bf48d9356395476f7ad';
  final String genresApiUrl = 'https://api.themoviedb.org/3/genre/movie/list?api_key=29cf44b93ca83bf48d9356395476f7ad';
  final String tvSeriesApiUrl = 'https://api.themoviedb.org/3/tv/popular?api_key=29cf44b93ca83bf48d9356395476f7ad';
  final String tvGenresApiUrl = 'https://api.themoviedb.org/3/genre/tv/list?api_key=29cf44b93ca83bf48d9356395476f7ad';

  // Fetch movies
  Future<List> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['results'];
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch genres
  Future<List<Map<String, dynamic>>> fetchGenres() async {
    try {
      final response = await http.get(Uri.parse(genresApiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['genres']);
      } else {
        throw Exception('Failed to load genres');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch TV series
  Future<List> fetchTvSeries() async {
    try {
      final response = await http.get(Uri.parse(tvSeriesApiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['results'];
      } else {
        throw Exception('Failed to load TV Series');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch TV genres
  Future<List<Map<String, dynamic>>> fetchTvGenres() async {
    try {
      final response = await http.get(Uri.parse(tvGenresApiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['genres']);
      } else {
        throw Exception('Failed to load TV genres');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch recommendations
  Future<List> fetchRecommendations(String type, int id) async {
    final String url = 'https://api.themoviedb.org/3/$type/$id/recommendations?api_key=29cf44b93ca83bf48d9356395476f7ad';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['results'];
      } else {
        throw Exception('Failed to load $type recommendations');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<MovieDetailsModel> fetchMovieDetails(int id) async {
    final String url = 'https://api.themoviedb.org/3/movie/$id?api_key=29cf44b93ca83bf48d9356395476f7ad'; 
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return MovieDetailsModel.fromJson(data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
}
Future<TvDetailsModel> fetchTvDetails(int id) async {
    final String url = 'https://api.themoviedb.org/3/tv/$id?api_key=29cf44b93ca83bf48d9356395476f7ad'; 
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return TvDetailsModel.fromJson(data);
      } else {
        throw Exception('Failed to load TV details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
}
}