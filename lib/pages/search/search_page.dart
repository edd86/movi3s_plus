import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:movi3s_plus/data/models/movie_model.dart';
import 'package:movi3s_plus/data/models/series_model.dart';
import 'package:movi3s_plus/data/repository/movies_repository.dart';
import 'package:movi3s_plus/data/repository/series_repository.dart';
import 'package:movi3s_plus/pages/provider/theme_provider.dart';
import 'package:movi3s_plus/pages/widgets/search_content.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool movie = true;
  bool tvSerie = false;
  final _searchController = TextEditingController();
  String title = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 60.w,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                ),
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return AnimatedToggleSwitch.dual(
                      current: movie,
                      first: true,
                      second: false,
                      style: ToggleStyle(
                        borderColor:
                            themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
                        indicatorColor:
                            themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
                      ),
                      iconBuilder:
                          (value) =>
                              value
                                  ? Icon(
                                    Icons.movie,
                                    color:
                                        themeProvider.isDarkMode
                                            ? Colors.black
                                            : Colors.white,
                                  )
                                  : Icon(
                                    Icons.tv,
                                    color:
                                        themeProvider.isDarkMode
                                            ? Colors.black
                                            : Colors.white,
                                  ),
                      textBuilder:
                          (value) => value ? Text('Películas') : Text('Series'),
                      onChanged:
                          (value) => setState(() {
                            movie = value;
                            tvSerie = !value;
                          }),
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future:
                    movie
                        ? MoviesRepository().searchMovies(title)
                        : SeriesRepository().searchSerieByTitle(title),
                builder: (context, snpashot) {
                  if (snpashot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snpashot.hasError) {
                    return Text(snpashot.error.toString());
                  }
                  if (snpashot.hasData) {
                    if (movie) {
                      final movies = snpashot.data! as List<MovieModel>;
                      return movies.isEmpty
                          ? Center(
                            child: Text('Ingrese el nombre de la película'),
                          )
                          : SearchContent(movies: movies);
                    } else {
                      final series = snpashot.data! as List<Serie>;
                      return series.isEmpty
                          ? Center(child: Text('Ingrese el nombre de la serie'))
                          : SearchContent(series: series);
                    }
                  } else {
                    return Center(child: Text('No hay datos de películas'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
