import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movi3s_plus/data/models/movie_model.dart';
import 'package:sizer/sizer.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final String imgurl = dotenv.env['IMG_URL']!;
  MovieCard({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: OverflowBox(
        maxHeight: 35.h,
        child: Image(
          fit: BoxFit.cover,
          image: NetworkImage('$imgurl${movie.posterPath}'),
        ),
      ),
    );
  }
}
