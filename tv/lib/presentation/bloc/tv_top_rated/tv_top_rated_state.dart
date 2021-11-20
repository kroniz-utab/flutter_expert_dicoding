part of 'tv_top_rated_bloc.dart';

@immutable
abstract class TvTopRatedState extends Equatable {}

class TvTopRatedEmpty extends TvTopRatedState {
  @override
  List<Object?> get props => [];
}

class TvTopRatedLoading extends TvTopRatedState {
  @override
  List<Object?> get props => [];
}

class TvTopRatedError extends TvTopRatedState {
  final String message;

  TvTopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvTopRatedHasData extends TvTopRatedState {
  final List<TV> result;

  TvTopRatedHasData(this.result);

  @override
  List<Object?> get props => [];
}
