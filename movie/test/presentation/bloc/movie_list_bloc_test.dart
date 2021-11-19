import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects_movie.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetNowPlayingMovies usecase;
  late MovieListBloc movieBloc;

  setUp(() {
    usecase = MockGetNowPlayingMovies();
    movieBloc = MovieListBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(movieBloc.state, MovieListEmpty());
  });

  blocTest<MovieListBloc, MovieListState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMovieListCalled()),
    expect: () => [
      MovieListLoading(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnMovieListCalled().props;
    },
  );

  blocTest<MovieListBloc, MovieListState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMovieListCalled()),
    expect: () => [
      MovieListLoading(),
      MovieListError('Server Failure'),
    ],
    verify: (bloc) => MovieListLoading(),
  );

  blocTest<MovieListBloc, MovieListState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMovieListCalled()),
    expect: () => [
      MovieListLoading(),
      MovieListEmpty(),
    ],
  );
}
