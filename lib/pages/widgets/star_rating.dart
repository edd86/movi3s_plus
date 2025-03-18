import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color color;
  const StarRating({
    required this.rating,
    required this.starSize,
    this.color = Colors.amber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    double reminder = rating - fullStars;
    bool hasHalfStar = reminder >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(10, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, color: color, size: starSize);
        } else if(hasHalfStar && index == fullStars) {
          return Icon(Icons.star_half, color: color, size: starSize);
        } else {
          return Icon(Icons.star_border, color: color, size: starSize);
        }
      }),
    );
  }
}
