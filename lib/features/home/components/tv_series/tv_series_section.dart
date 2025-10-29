import 'package:flutter/material.dart';
import 'package:movie/features/details/details_screen.dart';
import 'package:movie/features/home/data/apis/get_list.dart';
import 'package:movie/features/home/components/tv_series/tv_series_card.dart';

class TvSeriesSection extends StatefulWidget {
  const TvSeriesSection({super.key});

  @override
  State<TvSeriesSection> createState() => _TvSeriesSectionState();
}

class _TvSeriesSectionState extends State<TvSeriesSection> {
  MoviesService moviesService = MoviesService();
  List<Map<String, dynamic>> tvGenres = [];

  @override
  void initState() {
    super.initState();
    moviesService.fetchTvGenres().then((data) {
      setState(() {
        tvGenres = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder<List>(
            future: moviesService.fetchTvSeries(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No TV series found'));
              } else {
                return Row(
                  children: snapshot.data!.map<Widget>((tvSeries) {
                    return TvSeriesCard(
                      tvSeries: tvSeries,
                      genres: tvGenres,
                      onTap: () {
                        // هنا يمكنك إضافة منطق عرض تفاصيل السلسلة مثل الانتقال إلى شاشة جديدة.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                // MyDetailsPage(tvSeriesId: tvSeries['id']),
                                MyDetailsPage(),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
