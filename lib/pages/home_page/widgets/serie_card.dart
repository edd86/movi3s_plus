import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movi3s_plus/data/models/series_model.dart';
import 'package:sizer/sizer.dart';

class SerieCard extends StatelessWidget {
  SerieCard({required this.serie, super.key});

  final Serie serie;
  final String imgurl = dotenv.env['IMG_URL']!;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: OverflowBox(
        maxHeight: 35.h,
        child: Image(
          fit: BoxFit.cover,
          image: NetworkImage('$imgurl${serie.posterPath}'),
        ),
      ),
    );
  }
}