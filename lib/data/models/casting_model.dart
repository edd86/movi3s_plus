class Casting {
  final int? id;
  final List<Cast>? cast;
  final List<Cast>? crew;

  Casting({this.id, this.cast, this.crew});

  factory Casting.fromJson(Map<String, dynamic> json) => Casting(
    id: json["id"],
    cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
    crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cast": List<dynamic>.from(cast!.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew!.map((x) => x.toJson())),
  };
}

class Cast {
  final bool? adult;
  final int? gender;
  final int? id;
  final Department? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String? creditId;
  final int? order;
  final Department? department;
  final String? job;

  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: departmentValues.map[json["known_for_department"]],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"].toDouble(),
    profilePath: json["profile_path"],
    castId: json["cast_id"],
    character: json["character"],
    creditId: json["credit_id"],
    order: json["order"],
    department: departmentValues.map[json["department"]],
    job: json["job"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": departmentValues.reverse[knownForDepartment],
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "cast_id": castId,
    "character": character,
    "credit_id": creditId,
    "order": order,
    "department": departmentValues.reverse[department],
    "job": job,
  };
}

enum Department {
  ACTING,
  ART,
  CAMERA,
  COSTUME_MAKE_UP,
  CREW,
  DIRECTING,
  EDITING,
  PRODUCTION,
  SOUND,
  VISUAL_EFFECTS,
  WRITING,
}

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Art": Department.ART,
  "Camera": Department.CAMERA,
  "Costume & Make-Up": Department.COSTUME_MAKE_UP,
  "Crew": Department.CREW,
  "Directing": Department.DIRECTING,
  "Editing": Department.EDITING,
  "Production": Department.PRODUCTION,
  "Sound": Department.SOUND,
  "Visual Effects": Department.VISUAL_EFFECTS,
  "Writing": Department.WRITING,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
