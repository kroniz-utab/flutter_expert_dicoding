import 'package:ditonton/domain/entities/tv_entities/crew.dart';
import 'package:equatable/equatable.dart';

class CrewModel extends Equatable {
  CrewModel({
    required this.job,
    required this.department,
    required this.creditId,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
  });

  final String job;
  final String department;
  final String creditId;
  final bool? adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;

  factory CrewModel.fromJson(Map<String, dynamic> json) => CrewModel(
        job: json["job"],
        department: json["department"],
        creditId: json["credit_id"],
        adult: json["adult"] == null ? null : json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "job": job,
        "department": department,
        "credit_id": creditId,
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
      };

  Crew toEntity() {
    return Crew(
      job: this.job,
      department: this.department,
      creditId: this.creditId,
      adult: this.adult,
      gender: this.gender,
      id: this.id,
      knownForDepartment: this.knownForDepartment,
      name: this.name,
      originalName: this.originalName,
      popularity: this.popularity,
      profilePath: this.profilePath,
    );
  }

  @override
  List<Object?> get props => [
        job,
        department,
        creditId,
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
