import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';
import 'package:watchlist/presentation/bloc/tvShow/tv_watchlist_bloc.dart';

// tv detail
class FakeTvDetailEvent extends Fake implements TvDetailEvent {}

class FakeTvDetailState extends Fake implements TvDetailState {}

class FakeTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

// tv list
class FakeTvListEvent extends Fake implements TvListEvent {}

class FakeTvListState extends Fake implements TvListState {}

class FakeTvListBloc extends MockBloc<TvListEvent, TvListState>
    implements TvListBloc {}

// tv popular
class FakeTvPopularEvent extends Fake implements TvPopularEvent {}

class FakeTvPopularState extends Fake implements TvPopularState {}

class FakeTvPopularBloc extends MockBloc<TvPopularEvent, TvPopularState>
    implements TvPopularBloc {}

// tv recom
class FakeTvRecomEvent extends Fake implements TvRecommendationEvent {}

class FakeTvRecomState extends Fake implements TvRecommendationState {}

class FakeTvRecomBloc
    extends MockBloc<TvRecommendationEvent, TvRecommendationState>
    implements TvRecommendationBloc {}

// season detail
class FakeSeasonDetailEvent extends Fake implements TvSeasonDetailEvent {}

class FakeSeasonDetailState extends Fake implements TvSeasonDetailState {}

class FakeSeasonDetailBloc
    extends MockBloc<TvSeasonDetailEvent, TvSeasonDetailState>
    implements TvSeasonDetailBloc {}

// tv similar
class FakeSimilarEvent extends Fake implements TvSimilarEvent {}

class FakeSimilarState extends Fake implements TvSimilarState {}

class FakeSimilarBloc extends MockBloc<TvSimilarEvent, TvSimilarState>
    implements TvSimilarBloc {}

// tv top rate
class FakeTvTopEvent extends Fake implements TvTopRatedEvent {}

class FakeTvTopState extends Fake implements TvTopRatedState {}

class FakeTvTopBloc extends MockBloc<TvTopRatedEvent, TvTopRatedState>
    implements TvTopRatedBloc {}

// tv watchlist
class FakeTvWatchlistEvent extends Fake implements TvWatchlistEvent {}

class FakeTvWatchlistState extends Fake implements TvWatchlistState {}

class FakeTvWatchlistBloc extends MockBloc<TvWatchlistEvent, TvWatchlistState>
    implements TvWatchlistBloc {}
