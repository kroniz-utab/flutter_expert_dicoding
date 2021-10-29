import 'package:ditonton/domain/entities/tv_entities/crew.dart';
import 'package:ditonton/domain/entities/tv_entities/guest_star.dart';
import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final String airDate;
  final int episodeNumber;
  final List<Crew> crew;
  final List<GuestStar> guestStars;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.crew,
    required this.guestStars,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        crew,
        guestStars,
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
