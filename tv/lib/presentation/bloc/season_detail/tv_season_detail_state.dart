part of 'tv_season_detail_bloc.dart';

@immutable
abstract class TvSeasonDetailState extends Equatable {}

class TvSeasonDetailEmpty extends TvSeasonDetailState {
  @override
  List<Object?> get props => [];
}

class TvSeasonDetailLoading extends TvSeasonDetailState {
  @override
  List<Object?> get props => [];
}

class TvSeasonDetailError extends TvSeasonDetailState {
  final String message;

  TvSeasonDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvSeasonDetailHasData extends TvSeasonDetailState {
  final SeasonDetail result;

  TvSeasonDetailHasData(this.result);

  @override
  List<Object?> get props => [result];
}
