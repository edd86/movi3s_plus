import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movi3s_plus/core/utils/conversors.dart';
import 'package:movi3s_plus/data/repository/movies_repository.dart';
import 'package:movi3s_plus/pages/widgets/cast_card.dart';
import 'package:movi3s_plus/pages/widgets/star_rating.dart';
import 'package:sizer/sizer.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  const MovieDetailsPage({required this.movieId, super.key});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: MoviesRepository().getMovieDetails(widget.movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            final movieDetails = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title:
                    movieDetails.title != null
                        ? Text(
                          movieDetails.title!,
                          style: GoogleFonts.lora(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        : Text(''),
                automaticallyImplyLeading: false,
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        height: 35.h,
                        '${dotenv.env['IMG_URL']}${movieDetails.posterPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child: SizedBox(
                        width: 70.w,
                        height: 2.h,
                        child:
                            movieDetails.genres != null
                                ? ListView.separated(
                                  itemCount: movieDetails.genres!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      '${movieDetails.genres![index].name}',
                                      style: GoogleFonts.lora(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (context, index) => SizedBox(width: 2.w),
                                )
                                : SizedBox(),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child:
                          movieDetails.productionCompanies != null
                              ? SizedBox(
                                width: 80.w,
                                height: 4.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder:
                                      (context, index) => SizedBox(width: 2.w),
                                  itemCount:
                                      movieDetails.productionCompanies!.length,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      '${dotenv.env['IMG_URL']}${movieDetails.productionCompanies![index].logoPath}',
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Icon(Icons.error, size: 4.h),
                                    );
                                  },
                                ),
                              )
                              : SizedBox(),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child:
                          movieDetails.runtime != null
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Estreno: ${Conversors.convertDateToString(movieDetails.releaseDate!)}',
                                    style: GoogleFonts.lora(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    'Duración: ${movieDetails.runtime}',
                                    style: GoogleFonts.lora(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                              : Text('Duración: Unkown'),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child:
                          movieDetails.overview != null
                              ? Text(
                                '${movieDetails.overview}',
                                style: GoogleFonts.lora(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              )
                              : SizedBox(),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child:
                          movieDetails.voteAverage != null
                              ? StarRating(
                                rating: movieDetails.voteAverage!,
                                starSize: 22.sp,
                              )
                              : Text('Rating: Unkown'),
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      height: 200,
                      child: FutureBuilder(
                        future: MoviesRepository().getMovieCast(widget.movieId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          if (snapshot.hasData) {
                            final cast = snapshot.data!;
                            return SizedBox(
                              width: double.infinity,
                              child: ListView.separated(
                                itemCount: cast.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CastCard(cast: cast[index]);
                                },
                                separatorBuilder:
                                    (context, index) => SizedBox(width: 2.w),
                              ),
                            );
                          } else {
                            return Center(
                              child: Text('No hay datos de casting'),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No hay datos de la película'));
          }
        },
      ),
    );
  }
}
