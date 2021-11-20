import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_entities/tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/tv.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTVShowDetail _getTVShowDetail;

  TvDetailBloc(
    this._getTVShowDetail,
  ) : super(TvDetailEmpty()) {
    on<OnTvDetailCalled>(_onTvDetailCalled);
  }

  FutureOr<void> _onTvDetailCalled(
    OnTvDetailCalled event,
    Emitter<TvDetailState> emit,
  ) async {
    final id = event.id;
    emit(TvDetailLoading());

    final result = await _getTVShowDetail.execute(id);

    result.fold(
      (failure) {
        emit(TvDetailError(failure.message));
      },
      (data) {
        emit(TvDetailHasData(data));
      },
    );
  }
}
