import '../../../domain/entities/tv_entities/episode_to_air.dart';
import 'package:equatable/equatable.dart';

class TEpisodeToAirModel extends Equatable {
  const TEpisodeToAirModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double? voteAverage;
  final int voteCount;

  factory TEpisodeToAirModel.fromJson(Map<String, dynamic> json) =>
      TEpisodeToAirModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"] ?? json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath ?? stillPath,
        "vote_average": voteAverage!.toDouble(),
        "vote_count": voteCount,
      };

  TEpisodeToAir toEntity() {
    return TEpisodeToAir(
      airDate: airDate,
      episodeNumber: episodeNumber,
      id: id,
      name: name,
      overview: overview,
      productionCode: productionCode,
      seasonNumber: seasonNumber,
      stillPath: stillPath,
      voteAverage: voteAverage!.toDouble(),
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
