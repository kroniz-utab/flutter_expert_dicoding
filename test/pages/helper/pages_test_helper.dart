import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

class FakeMovieListEvent extends Fake implements MovieListEvent {}

class FakeMovieListState extends Fake implements MovieListState {}

class FakeMovieListBloc extends MockBloc<MovieListEvent, MovieListState>
    implements MovieListBloc {}

class FakePopularMovieEvent extends Fake implements MoviePopularEvent {}

class FakePopularMovieState extends Fake implements MoviePopularState {}

class FakePopularMovieBloc
    extends MockBloc<MoviePopularEvent, MoviePopularState>
    implements MoviePopularBloc {}

class FakeTvListEvent extends Fake implements TvListEvent {}

class FakeTvListState extends Fake implements TvListState {}

class FakeTvListBloc extends MockBloc<TvListEvent, TvListState>
    implements TvListBloc {}

class FakePopularTvEvent extends Fake implements TvPopularEvent {}

class FakePopularTvState extends Fake implements TvPopularState {}

class FakePopularTvBloc extends MockBloc<TvPopularEvent, TvPopularState>
    implements TvPopularBloc {}
