import 'package:movi3s_plus/data/models/movie_model.dart';

class NowPlaying {
  final Dates? dates;
  final int? page;
  final List<MovieModel>? movies;
  final int? totalPages;
  final int? totalResults;

  NowPlaying({
    this.dates,
    this.page,
    this.movies,
    this.totalPages,
    this.totalResults,
  });

  factory NowPlaying.fromJson(Map<String, dynamic> json) => NowPlaying(
    dates: Dates.fromJson(json["dates"]),
    page: json["page"],
    movies: List<MovieModel>.from(
      json["results"].map((x) => MovieModel.fromJson(x)),
    ),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "dates": dates!.toJson(),
    "page": page,
    "movies": List<dynamic>.from(movies!.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Dates {
  final DateTime? maximum;
  final DateTime? minimum;

  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );

  Map<String, dynamic> toJson() => {
    "maximum":
        "${maximum!.year.toString().padLeft(4, '0')}-${maximum!.month.toString().padLeft(2, '0')}-${maximum!.day.toString().padLeft(2, '0')}",
    "minimum":
        "${minimum!.year.toString().padLeft(4, '0')}-${minimum!.month.toString().padLeft(2, '0')}-${minimum!.day.toString().padLeft(2, '0')}",
  };
}
