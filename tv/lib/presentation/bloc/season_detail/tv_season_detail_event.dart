part of 'tv_season_detail_bloc.dart';

@immutable
abstract class TvSeasonDetailEvent extends Equatable {}

class OnSeasonDetailCalled extends TvSeasonDetailEvent {
  final int id;
  final int season;

  OnSeasonDetailCalled(this.id, this.season);

  @override
  List<Object?> get props => [
        id,
        season,
      ];
}
