import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/presentation/cubit/movie_details_cubit/movie_cubit.dart' show MovieCubit;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie/features/home/components/popular/popular_section.dart';
import 'package:movie/features/home/components/tv_series/tv_series_section.dart';
import 'package:movie/features/home/components/you_may_like/you_may_like_section.dart';
import 'package:movie/features/home/data/apis/get_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  String? userName; // لإظهار اسم المستخدم في الـ AppBar

  @override
  void initState() {
    super.initState();
    _loadUserData(); // تحميل اسم المستخدم عند فتح الصفحة
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    var response = await MoviesService().fetchMovies();
    var filteredResults = response.where((movie) {
      return movie['title'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      searchResults = filteredResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
          child: ClipOval(
            child: Image.asset(
              'assets/images/user_avatar.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            userName != null ? "Hello $userName" : "Hello User",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: const Text(
            "Enjoy your favorite movies",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, size: 28),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) {
              _searchMovies(value);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(70, 69, 69, 1),
              hintText: 'Search Movie...',
              prefixIcon: const Icon(Icons.search, color: Colors.black),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.black),
                      onPressed: () {
                        _searchController.clear();
                        _searchMovies("");
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          if (searchResults.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text("Search Results", style: TextStyle(fontSize: 20)),
            ),
          if (searchResults.isNotEmpty)
            Column(
              children: searchResults.map((movie) {
                return ListTile(
                  title: Text(movie['title']),
                  subtitle: Text(movie['overview']),
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                  ),
                );
              }).toList(),
            ),
          if (searchResults.isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("Popular Movies", style: TextStyle(fontSize: 20)),
                ),
                PopularSection(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("TV Series", style: TextStyle(fontSize: 20)),
                ),
                TvSeriesSection(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("You May Like", style: TextStyle(fontSize: 20)),
                ),
                BlocProvider(
                  create: (context) => MovieCubit(),
                  child: YouMayLikeSection(),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
