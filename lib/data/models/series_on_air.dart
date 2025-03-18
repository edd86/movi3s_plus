import 'package:movi3s_plus/data/models/series_model.dart';

class SeriesOnAir {
    final int? page;
    final List<Serie>? series;
    final int? totalPages;
    final int? totalResults;

    SeriesOnAir({
        this.page,
        this.series,
        this.totalPages,
        this.totalResults,
    });

    factory SeriesOnAir.fromJson(Map<String, dynamic> json) => SeriesOnAir(
        page: json["page"],
        series: List<Serie>.from(json["results"].map((x) => Serie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(series!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}