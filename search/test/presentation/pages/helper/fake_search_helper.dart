import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';

class FakeMovieSearchEvent extends Fake implements SearchMoviesEvent {}

class FakeMovieSearchState extends Fake implements SearchMoviesState {}

class FakeMovieSearchBloc extends MockBloc<SearchMoviesEvent, SearchMoviesState>
    implements SearchMoviesBloc {}

class FakeTVSearchEvent extends Fake implements SearchTvEvent {}

class FakeTVSearchState extends Fake implements SearchTvState {}

class FakeTVSearchBloc extends MockBloc<SearchTvEvent, SearchTvState>
    implements SearchTvBloc {}
