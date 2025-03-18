import 'package:flutter_dotenv/flutter_dotenv.dart';

final String apiKey = dotenv.env['API_KEY']!;

String topRatedMovies =
    'https://api.themoviedb.org/3/movie/top_rated?language=es-MX&page=1&api_key=$apiKey';

String nowPlayingMovies =
    'https://api.themoviedb.org/3/movie/now_playing?language=es-MX&page=1&api_key=$apiKey';

String tvSeriesNowPlaying =
    'https://api.themoviedb.org/3/tv/top_rated?language=es-MX&page=1&api_key=$apiKey';

String tvSeriesOnAir =
    'https://api.themoviedb.org/3/tv/on_the_air?language=es-MX&page=1&api_key=$apiKey';

String movieDetails(int id) =>
    'https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=es-MX';

String movierCasting(int id) =>
    'https://api.themoviedb.org/3/movie/$id/credits?api_key=$apiKey&language=es-MX';

String searchMovieByTitle(String title) =>
    'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=es-MX&query=$title';

String tvSeriesDetails(int id) =>
    'https://api.themoviedb.org/3/tv/$id?api_key=$apiKey&language=es-MX';

String tvSeriesCasting(int id) =>
    'https://api.themoviedb.org/3/tv/$id/credits?api_key=$apiKey&language=es-MX';

String searchTvSerieByTitle(String title) =>
    'https://api.themoviedb.org/3/search/tv?api_key=$apiKey&language=es-MX&query=$title';
