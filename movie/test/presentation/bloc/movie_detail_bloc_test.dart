import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects_movie.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetMovieDetail usecase;
  late MovieDetailBloc movieBloc;

  const tId = 1;

  setUp(() {
    usecase = MockGetMovieDetail();
    movieBloc = MovieDetailBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(movieBloc.state, MovieDetailEmpty());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => const Right(testMovieDetail));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMovieDetailCalled(tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
      return OnMovieDetailCalled(tId).props;
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieBloc;
    },
    act: (bloc) => bloc.add(OnMovieDetailCalled(tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError('Server Failure'),
    ],
    verify: (bloc) => MovieDetailLoading(),
  );
}
