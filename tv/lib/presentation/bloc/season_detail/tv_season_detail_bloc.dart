import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/tv.dart';

part 'tv_season_detail_event.dart';
part 'tv_season_detail_state.dart';

class TvSeasonDetailBloc
    extends Bloc<TvSeasonDetailEvent, TvSeasonDetailState> {
  final GetTVSeasonDetail _getTVSeasonDetail;

  TvSeasonDetailBloc(
    this._getTVSeasonDetail,
  ) : super(TvSeasonDetailEmpty()) {
    on<OnSeasonDetailCalled>(_onTvSeasonDetailCalled);
  }

  FutureOr<void> _onTvSeasonDetailCalled(
    OnSeasonDetailCalled event,
    Emitter<TvSeasonDetailState> emit,
  ) async {
    final id = event.id;
    final season = event.season;
    emit(TvSeasonDetailLoading());

    final result = await _getTVSeasonDetail.execute(id, season);

    result.fold(
      (failure) {
        emit(TvSeasonDetailError(failure.message));
      },
      (data) {
        emit(TvSeasonDetailHasData(data));
      },
    );
  }
}
