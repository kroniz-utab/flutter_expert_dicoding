part of 'search_tv_bloc.dart';

@immutable
abstract class SearchTvEvent extends Equatable {}

class OnQueryTvChange extends SearchTvEvent {
  final String query;

  OnQueryTvChange(this.query);

  @override
  List<Object> get props => [query];
}
