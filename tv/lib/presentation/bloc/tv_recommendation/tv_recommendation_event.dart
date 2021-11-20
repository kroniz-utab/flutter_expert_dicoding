part of 'tv_recommendation_bloc.dart';

@immutable
abstract class TvRecommendationEvent extends Equatable {}

class OnTvRecommendationCalled extends TvRecommendationEvent {
  final int id;

  OnTvRecommendationCalled(this.id);

  @override
  List<Object?> get props => [id];
}
