import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/tv.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTVShows _getPopularTVShows;

  TvPopularBloc(
    this._getPopularTVShows,
  ) : super(TvPopularEmpty()) {
    on<OnTvPopularCalled>(_onTvPopularCalled);
  }

  FutureOr<void> _onTvPopularCalled(
    OnTvPopularCalled event,
    Emitter<TvPopularState> emit,
  ) async {
    emit(TvPopularLoading());

    final result = await _getPopularTVShows.execute();

    result.fold(
      (failure) {
        emit(TvPopularError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(TvPopularEmpty()) : emit(TvPopularHasData(data));
      },
    );
  }
}
