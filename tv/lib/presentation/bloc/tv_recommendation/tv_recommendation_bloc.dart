import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/tv.dart';

part 'tv_recommendation_event.dart';
part 'tv_recommendation_state.dart';

class TvRecommendationBloc
    extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final GetTVRecommendations _getTVRecommendations;

  TvRecommendationBloc(this._getTVRecommendations)
      : super(TvRecommendationEmpty()) {
    on<OnTvRecommendationCalled>(_onTvRecommendationCalled);
  }

  FutureOr<void> _onTvRecommendationCalled(
    OnTvRecommendationCalled event,
    Emitter<TvRecommendationState> emit,
  ) async {
    final id = event.id;
    emit(TvRecommendationLoading());

    final result = await _getTVRecommendations.execute(id);

    result.fold(
      (failure) {
        emit(TvRecommendationError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TvRecommendationEmpty())
            : emit(TvRecommendationHasData(data));
      },
    );
  }
}
