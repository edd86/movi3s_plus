import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movi3s_plus/data/repository/movies_repository.dart';
import 'package:movi3s_plus/data/repository/series_repository.dart';
import 'package:movi3s_plus/pages/home_page/widgets/movie_card.dart';
import 'package:movi3s_plus/pages/home_page/widgets/serie_card.dart';
import 'package:movi3s_plus/pages/movie/movie_details_page.dart';
import 'package:movi3s_plus/pages/provider/theme_provider.dart';
import 'package:movi3s_plus/pages/search/search_page.dart';
import 'package:movi3s_plus/pages/tvseries/tv_serie_details.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  final _carouselController = CarouselController(initialItem: 1);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  ),
              icon: Icon(Icons.search),
            ),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return IconButton(
                  icon:
                      themeProvider.isDarkMode
                          ? Icon(Icons.light_mode)
                          : Icon(Icons.dark_mode),
                  onPressed: () {
                    final provider = Provider.of<ThemeProvider>(
                      context,
                      listen: false,
                    );
                    provider.isDarkMode = !provider.isDarkMode;
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Top Rated',
                  style: GoogleFonts.lora(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder(
                future: MoviesRepository().getTopRatedMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    final movies = snapshot.data!.movies;
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 35.h),
                      child: CarouselView.weighted(
                        controller: _carouselController,
                        flexWeights: [2, 7, 2],
                        children:
                            movies!.map((movie) {
                              return MovieCard(movie: movie);
                            }).toList(),
                        onTap: (value) {
                          //print(movies[value].id!);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => MovieDetailsPage(
                                    movieId: movies[value].id!,
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: Text('No hay datos de películas'));
                  }
                },
              ),
              Center(
                child: Text(
                  'Now Playing',
                  style: GoogleFonts.lora(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder(
                future: MoviesRepository().getNowPlayingMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    final movies = snapshot.data!.movies;
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 35.h),
                      child: CarouselView.weighted(
                        controller: _carouselController,
                        flexWeights: [2, 7, 2],
                        children:
                            movies!.map((movie) {
                              return MovieCard(movie: movie);
                            }).toList(),
                        onTap: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => MovieDetailsPage(
                                    movieId: movies[value].id!,
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: Text('No hay datos de películas'));
                  }
                },
              ),
              Center(
                child: Text(
                  'Top rated Tv Series',
                  style: GoogleFonts.lora(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder(
                future: SeriesRepository().getTopRatedSeries(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    final series = snapshot.data!.series;
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 35.h),
                      child: CarouselView.weighted(
                        controller: _carouselController,
                        flexWeights: [2, 7, 2],
                        children:
                            series!.map((serie) {
                              return SerieCard(serie: serie);
                            }).toList(),
                        onTap: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => TvSerieDetails(
                                    tvSerieId: series[value].id!,
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: Text('No hay datos de series'));
                  }
                },
              ),
              Center(
                child: Text(
                  'Tv Series On Air',
                  style: GoogleFonts.lora(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder(
                future: SeriesRepository().getSeriesOnAir(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    final movies = snapshot.data!.series;
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 35.h),
                      child: CarouselView.weighted(
                        controller: _carouselController,
                        flexWeights: [2, 9, 1],
                        children:
                            movies!.map((serie) {
                              return SerieCard(serie: serie);
                            }).toList(),
                      ),
                    );
                  } else {
                    return Center(child: Text('No hay datos de series'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
