import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/tv.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetTVOnTheAir _getTVOnTheAir;

  TvListBloc(this._getTVOnTheAir) : super(TvListEmpty()) {
    on<OnTvShowListCalled>(_onTvShowListCalled);
  }

  FutureOr<void> _onTvShowListCalled(
      OnTvShowListCalled event, Emitter<TvListState> emit) async {
    emit(TvListLoading());

    final result = await _getTVOnTheAir.execute();

    result.fold(
      (failure) {
        emit(TvListError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(TvListEmpty()) : emit(TvListHasData(data));
      },
    );
  }
}
