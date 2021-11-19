import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/entities/tv_entities/tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/watchlist.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTVShows _getWatchlistTVShows;
  final GetWatchlistTVStatus _getWatchlistTVStatus;
  final RemoveTVWatchlist _removeTvWatchlist;
  final SaveTVWatchList _saveTVWatchList;

  TvWatchlistBloc(
    this._getWatchlistTVShows,
    this._getWatchlistTVStatus,
    this._saveTVWatchList,
    this._removeTvWatchlist,
  ) : super(TvWatchlistInitial()) {
    on<OnFetchTvWatchlist>(_onFetchTvWatchlist);
    on<FetchTvWatchlistStatus>(_fetchTvWatchlistStatus);
    on<AddTvToWatchlist>(_addTvToWatchlist);
    on<RemoveTvFromWatchlist>(_remoteTvFromWatchlist);
  }

  FutureOr<void> _onFetchTvWatchlist(
    OnFetchTvWatchlist event,
    Emitter<TvWatchlistState> emit,
  ) async {
    emit(TvWatchlistLoading());

    final result = await _getWatchlistTVShows.execute();

    result.fold(
      (failure) {
        emit(TvWatchlistError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TvWatchlistEmpty())
            : emit(TvWatchlistHasData(data));
      },
    );
  }

  FutureOr<void> _fetchTvWatchlistStatus(
    FetchTvWatchlistStatus event,
    Emitter<TvWatchlistState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchlistTVStatus.execute(id);

    emit(TvIsAddedToWatchlist(result));
  }

  FutureOr<void> _addTvToWatchlist(
    AddTvToWatchlist event,
    Emitter<TvWatchlistState> emit,
  ) async {
    final tv = event.tv;

    final result = await _saveTVWatchList.execute(tv);

    result.fold(
      (failure) {
        emit(TvWatchlistError(failure.message));
      },
      (message) {
        emit(TvWatchlistMessage(message));
      },
    );
  }

  FutureOr<void> _remoteTvFromWatchlist(
    RemoveTvFromWatchlist event,
    Emitter<TvWatchlistState> emit,
  ) async {
    final tv = event.tv;

    final result = await _removeTvWatchlist.execute(tv);

    result.fold(
      (failure) {
        emit(TvWatchlistError(failure.message));
      },
      (message) {
        emit(TvWatchlistMessage(message));
      },
    );
  }
}
