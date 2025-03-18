import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movi3s_plus/core/utils/conversors.dart';
import 'package:movi3s_plus/data/models/casting_model.dart';
import 'package:movi3s_plus/data/repository/series_repository.dart';
import 'package:movi3s_plus/pages/widgets/cast_card.dart';
import 'package:movi3s_plus/pages/widgets/star_rating.dart';
import 'package:sizer/sizer.dart';

class TvSerieDetails extends StatefulWidget {
  final int tvSerieId;
  const TvSerieDetails({required this.tvSerieId, super.key});

  @override
  State<TvSerieDetails> createState() => _TvSerieDetailsState();
}

class _TvSerieDetailsState extends State<TvSerieDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: SeriesRepository().getTvSerieDetails(widget.tvSerieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            final tvSerieDetails = snapshot.data!;
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        tvSerieDetails.name!,
                        style: GoogleFonts.lora(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child: Image.network(
                        height: 35.h,
                        '${dotenv.env['IMG_URL']}${tvSerieDetails.posterPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child:
                          tvSerieDetails.productionCompanies != null
                              ? SizedBox(
                                width: 80.w,
                                height: 4.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder:
                                      (context, index) => SizedBox(width: 2.w),
                                  itemCount:
                                      tvSerieDetails.productionCompanies!.length,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      '${dotenv.env['IMG_URL']}${tvSerieDetails.productionCompanies![index].logoPath}',
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'First Air Date: ${Conversors.convertDateToString(tvSerieDetails.firstAirDate!)}',
                            style: GoogleFonts.lora(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Last Air Date: ${Conversors.convertDateToString(tvSerieDetails.lastAirDate!)}',
                            style: GoogleFonts.lora(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child: Text(
                        '${tvSerieDetails.overview}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lora(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child: StarRating(
                        rating: tvSerieDetails.voteAverage!,
                        starSize: 22.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      height: 200,
                      child: FutureBuilder(
                        future: SeriesRepository().getTvSerieCast(
                          tvSerieDetails.id!,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          if (snapshot.hasData) {
                            final List<Cast> cast = snapshot.data!;
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
                            return Text('No data');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text('No data');
          }
        },
      ),
    );
  }
}
