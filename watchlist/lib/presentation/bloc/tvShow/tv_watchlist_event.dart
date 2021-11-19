part of 'tv_watchlist_bloc.dart';

@immutable
abstract class TvWatchlistEvent extends Equatable {}

class OnFetchTvWatchlist extends TvWatchlistEvent {
  @override
  List<Object> get props => [];
}

class FetchTvWatchlistStatus extends TvWatchlistEvent {
  final int id;

  FetchTvWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvToWatchlist extends TvWatchlistEvent {
  final TVDetail tv;

  AddTvToWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveTvFromWatchlist extends TvWatchlistEvent {
  final TVDetail tv;

  RemoveTvFromWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}
