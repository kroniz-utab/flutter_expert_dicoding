import '../../../domain/entities/tv_entities/guest_star.dart';
import 'package:equatable/equatable.dart';

class GuestStarModel extends Equatable {
  const GuestStarModel({
    required this.character,
    required this.creditId,
    required this.order,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
  });

  final String character;
  final String creditId;
  final int order;
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;

  factory GuestStarModel.fromJson(Map<String, dynamic> json) => GuestStarModel(
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        adult: json["adult"],
        gender: json["gender"] ?? json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] ?? json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "character": character,
        "credit_id": creditId,
        "order": order,
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
      };

  GuestStar toEntity() {
    return GuestStar(
      character: character,
      creditId: creditId,
      order: order,
      adult: adult,
      gender: gender,
      id: id,
      knownForDepartment: knownForDepartment,
      name: name,
      originalName: originalName,
      popularity: popularity,
      profilePath: profilePath,
    );
  }

  @override
  List<Object?> get props => [
        character,
        creditId,
        order,
        adult,
        gender,
        id,
        knownForDepartment,
        name,
        originalName,
        popularity,
        profilePath,
      ];
}
