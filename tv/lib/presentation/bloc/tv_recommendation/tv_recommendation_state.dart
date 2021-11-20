part of 'tv_recommendation_bloc.dart';

@immutable
abstract class TvRecommendationState extends Equatable {}

class TvRecommendationEmpty extends TvRecommendationState {
  @override
  List<Object?> get props => [];
}

class TvRecommendationLoading extends TvRecommendationState {
  @override
  List<Object?> get props => [];
}

class TvRecommendationError extends TvRecommendationState {
  final String message;

  TvRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvRecommendationHasData extends TvRecommendationState {
  final List<TV> result;

  TvRecommendationHasData(this.result);

  @override
  List<Object?> get props => [];
}
