part of 'tv_similar_bloc.dart';

@immutable
abstract class TvSimilarState extends Equatable {}

class TvSimilarEmpty extends TvSimilarState {
  @override
  List<Object?> get props => [];
}

class TvSimilarLoading extends TvSimilarState {
  @override
  List<Object?> get props => [];
}

class TvSimilarError extends TvSimilarState {
  final String message;

  TvSimilarError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvSimilarHasData extends TvSimilarState {
  final List<TV> result;

  TvSimilarHasData(this.result);

  @override
  List<Object?> get props => [];
}
