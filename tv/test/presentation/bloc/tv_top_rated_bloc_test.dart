import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetTopRatedTVShows usecase;
  late TvTopRatedBloc tvBloc;

  setUp(() {
    usecase = MockGetTopRatedTVShows();
    tvBloc = TvTopRatedBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TvTopRatedEmpty());
  });

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testTVList));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvTopRatedCalled()),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedHasData(testTVList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnTvTopRatedCalled().props;
    },
  );

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvTopRatedCalled()),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedError('Server Failure'),
    ],
    verify: (bloc) => TvTopRatedLoading(),
  );

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvTopRatedCalled()),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedEmpty(),
    ],
  );
}
