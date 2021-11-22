import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:watchlist/watchlist.dart';

/// movie list fake
class FakeMovieListEvent extends Fake implements MovieListEvent {}

class FakeMovieListState extends Fake implements MovieListState {}

class FakeMovieListBloc extends MockBloc<MovieListEvent, MovieListState>
    implements MovieListBloc {}

/// popular movie fake
class FakePopularMovieEvent extends Fake implements MoviePopularEvent {}

class FakePopularMovieState extends Fake implements MoviePopularState {}

class FakePopularMovieBloc
    extends MockBloc<MoviePopularEvent, MoviePopularState>
    implements MoviePopularBloc {}

/// top rated movie fake
class FakeTopRatedMovieEvent extends Fake implements MovieTopRatedEvent {}

class FakeTopRatedMovieState extends Fake implements MovieTopRatedState {}

class FakeTopRatedMovieBloc
    extends MockBloc<MovieTopRatedEvent, MovieTopRatedState>
    implements MovieTopRatedBloc {}

/// detail movie fake
class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

class FakeMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

/// recommendation movie fake
class FakeRecommendationMovieEvent extends Fake
    implements MovieRecommendationEvent {}

class FakeRecommendationMovieState extends Fake
    implements MovieRecommendationState {}

class FakeRecommendationMovieBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

/// watchlist movie fake
class FakeMovieWatchlistEvent extends Fake implements MovieWatchlistEvent {}

class FakeMovieWatchlistState extends Fake implements MovieWatchlistState {}

class FakeMovieWatchlistBloc
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}
