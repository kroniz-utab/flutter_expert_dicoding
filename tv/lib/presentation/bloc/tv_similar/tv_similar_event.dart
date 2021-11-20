part of 'tv_similar_bloc.dart';

@immutable
abstract class TvSimilarEvent extends Equatable {}

class OnTvSimilarCalled extends TvSimilarEvent {
  final int id;

  OnTvSimilarCalled(this.id);

  @override
  List<Object?> get props => [id];
}
