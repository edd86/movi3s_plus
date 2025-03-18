import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movi3s_plus/data/models/casting_model.dart';
import 'package:sizer/sizer.dart';

class CastCard extends StatelessWidget {
  final Cast cast;
  const CastCard({required this.cast, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Image.network(
            '${dotenv.env['IMG_URL']}${cast.profilePath}',
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Icon(Icons.person, size: 20.w));
            },
          ),
          Positioned(
            top: 170,
            child: Text(
              cast.name!,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                backgroundColor: const Color.fromARGB(181, 19, 19, 19),
              ),
            ),
          ),
          Positioned(
            top: 185,
            child: Text(
              cast.character!,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                backgroundColor: const Color.fromARGB(181, 19, 19, 19),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
