import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movi3s_plus/data/models/movie_model.dart';
import 'package:movi3s_plus/data/models/series_model.dart';
import 'package:movi3s_plus/pages/movie/movie_details_page.dart';
import 'package:movi3s_plus/pages/provider/theme_provider.dart';
import 'package:movi3s_plus/pages/tvseries/tv_serie_details.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SearchContent extends StatelessWidget {
  final List<MovieModel>? movies;
  final List<Serie>? series;
  const SearchContent({this.movies, this.series, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies != null ? movies!.length : series!.length,
      itemBuilder: (context, index) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return InkWell(
              child: Card(
                child: ListTile(
                  tileColor:
                      themeProvider.isDarkMode ? Colors.black : Colors.white,
                  leading: Image.network(
                    movies != null
                        ? '${dotenv.env['IMG_URL']}${movies![index].posterPath}'
                        : '${dotenv.env['IMG_URL']}${series![index].posterPath}',
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported),
                  ),
                  title: Text(
                    movies != null
                        ? movies![index].title!
                        : series![index].name!,
                    style: GoogleFonts.lora(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              onTap: () {
                if (movies != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              MovieDetailsPage(movieId: movies![index].id!),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              TvSerieDetails(tvSerieId: series![index].id!),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
