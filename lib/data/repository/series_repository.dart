import 'package:dio/dio.dart';
import 'package:movi3s_plus/data/datasources/end_points.dart';
import 'package:movi3s_plus/data/models/casting_model.dart';
import 'package:movi3s_plus/data/models/series_model.dart';
import 'package:movi3s_plus/data/models/series_on_air.dart';
import 'package:movi3s_plus/data/models/top_rated_series.dart';
import 'package:movi3s_plus/data/models/tvserie_details_model.dart';

class SeriesRepository {
  Future<TopRatedSeries> getTopRatedSeries() async {
    final dio = Dio();
    final response = await dio.get(tvSeriesNowPlaying);
    return TopRatedSeries.fromJson(response.data);
  }

  Future<SeriesOnAir> getSeriesOnAir() async {
    final dio = Dio();
    final response = await dio.get(tvSeriesOnAir);
    return SeriesOnAir.fromJson(response.data);
  }

  Future<TvserieDetailsModel> getTvSerieDetails(int id) async {
    final dio = Dio();
    final response = await dio.get(tvSeriesDetails(id));
    return TvserieDetailsModel.fromJson(response.data);
  }

  Future<List<Cast>> getTvSerieCast(int id) async {
    final dio = Dio();
    final response = await dio.get(tvSeriesCasting(id));
    return List<Cast>.from(
      response.data['cast'].map((cast) => Cast.fromJson(cast)),
    );
  }

  Future<List<Serie>> searchSerieByTitle(String title) async {
    final dio = Dio();
    final response = await dio.get(searchTvSerieByTitle(title));
    return List<Serie>.from(
      response.data['results'].map((serie) => Serie.fromJson(serie)),
    );
  }
}
