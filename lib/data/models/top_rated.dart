import 'package:movi3s_plus/data/models/movie_model.dart';

class TopRated {
  int? page;
  List<MovieModel>? movies;
  int? totalPages;
  int? totalResults;

  TopRated({this.page, this.movies, this.totalPages, this.totalResults});

  factory TopRated.fromJson(Map<String, dynamic> json) => TopRated(
    page: json["page"],
    movies: List<MovieModel>.from(
      json["results"].map((x) => MovieModel.fromJson(x)),
    ),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "movies": List<dynamic>.from(movies!.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}
