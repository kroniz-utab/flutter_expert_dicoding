part of 'search_tv_bloc.dart';

@immutable
abstract class SearchTvState extends Equatable {}

class SearchTvEmpty extends SearchTvState {
  @override
  List<Object> get props => [];
}

class SearchTvLoading extends SearchTvState {
  @override
  List<Object> get props => [];
}

class SearchTvError extends SearchTvState {
  final String message;

  SearchTvError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvHasData extends SearchTvState {
  final List<TV> result;

  SearchTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
