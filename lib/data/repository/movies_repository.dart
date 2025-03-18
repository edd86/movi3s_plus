import 'package:movi3s_plus/data/datasources/end_points.dart';
import 'package:movi3s_plus/data/models/casting_model.dart';
import 'package:movi3s_plus/data/models/movie_details_model.dart';
import 'package:movi3s_plus/data/models/movie_model.dart';
import 'package:movi3s_plus/data/models/playing_now.dart';
import 'package:movi3s_plus/data/models/top_rated.dart';
import 'package:dio/dio.dart';

class MoviesRepository {
  Future<TopRated> getTopRatedMovies() async {
    final dio = Dio();
    final response = await dio.get(topRatedMovies);
    return TopRated.fromJson(response.data);
  }

  Future<NowPlaying> getNowPlayingMovies() async {
    final dio = Dio();
    final response = await dio.get(nowPlayingMovies);
    return NowPlaying.fromJson(response.data);
  }

  Future<MovieDetails> getMovieDetails(int movieId) async {
    final dio = Dio();
    final response = await dio.get(movieDetails(movieId));
    return MovieDetails.fromJson(response.data);
  }

  Future<List<MovieModel>> searchMovies(String title) async {
    final dio = Dio();
    final response = await dio.get(searchMovieByTitle(title));
    return List<MovieModel>.from(
      response.data['results'].map((x) => MovieModel.fromJson(x)),
    );
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    final dio = Dio();
    final response = await dio.get(movierCasting(movieId));
    final cast = List<Cast>.from(
      response.data['cast'].map((x) => Cast.fromJson(x)),
    );
    return cast
            .where((element) => element.knownForDepartment == Department.ACTING)
            .toList();
  }
}
