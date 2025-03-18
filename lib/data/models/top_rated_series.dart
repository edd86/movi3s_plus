import 'package:movi3s_plus/data/models/series_model.dart';

class TopRatedSeries {
    final int? page;
    final List<Serie>? series;
    final int? totalPages;
    final int? totalResults;

    TopRatedSeries({
        this.page,
        this.series,
        this.totalPages,
        this.totalResults,
    });

    factory TopRatedSeries.fromJson(Map<String, dynamic> json) => TopRatedSeries(
        page: json["page"],
        series: List<Serie>.from(json["results"].map((x) => Serie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "series": List<dynamic>.from(series!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}