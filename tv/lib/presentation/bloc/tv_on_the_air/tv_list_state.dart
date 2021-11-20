part of 'tv_list_bloc.dart';

@immutable
abstract class TvListState extends Equatable {}

class TvListEmpty extends TvListState {
  @override
  List<Object?> get props => [];
}

class TvListLoading extends TvListState {
  @override
  List<Object?> get props => [];
}

class TvListError extends TvListState {
  final String message;

  TvListError(this.message);

  @override
  List<Object> get props => [message];
}

class TvListHasData extends TvListState {
  final List<TV> result;

  TvListHasData(this.result);

  @override
  List<Object?> get props => [result];
}
