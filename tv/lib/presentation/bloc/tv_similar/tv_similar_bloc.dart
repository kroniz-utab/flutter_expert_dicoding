import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/tv.dart';

part 'tv_similar_event.dart';
part 'tv_similar_state.dart';

class TvSimilarBloc extends Bloc<TvSimilarEvent, TvSimilarState> {
  final GetSimilarTVShows _getTVSimilars;

  TvSimilarBloc(this._getTVSimilars) : super(TvSimilarEmpty()) {
    on<OnTvSimilarCalled>(_onTvSimilarCalled);
  }

  FutureOr<void> _onTvSimilarCalled(
    OnTvSimilarCalled event,
    Emitter<TvSimilarState> emit,
  ) async {
    final id = event.id;
    emit(TvSimilarLoading());

    final result = await _getTVSimilars.execute(id);

    result.fold(
      (failure) {
        emit(TvSimilarError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(TvSimilarEmpty()) : emit(TvSimilarHasData(data));
      },
    );
  }
}
