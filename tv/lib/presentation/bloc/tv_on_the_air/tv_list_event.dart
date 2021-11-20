part of 'tv_list_bloc.dart';

@immutable
abstract class TvListEvent extends Equatable {}

class OnTvShowListCalled extends TvListEvent {
  @override
  List<Object?> get props => [];
}
