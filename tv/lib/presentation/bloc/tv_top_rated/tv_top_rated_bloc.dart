import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/tv.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTVShows _getTopRatedTVShows;

  TvTopRatedBloc(
    this._getTopRatedTVShows,
  ) : super(TvTopRatedEmpty()) {
    on<OnTvTopRatedCalled>(_onTvTopRatedCalled);
  }

  FutureOr<void> _onTvTopRatedCalled(
    OnTvTopRatedCalled event,
    Emitter<TvTopRatedState> emit,
  ) async {
    emit(TvTopRatedLoading());

    final result = await _getTopRatedTVShows.execute();

    result.fold(
      (failure) {
        emit(TvTopRatedError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(TvTopRatedEmpty()) : emit(TvTopRatedHasData(data));
      },
    );
  }
}
