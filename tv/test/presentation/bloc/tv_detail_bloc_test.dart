import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetTVShowDetail usecase;
  late TvDetailBloc tvBloc;

  const tId = 1;

  setUp(() {
    usecase = MockGetTVShowDetail();
    tvBloc = TvDetailBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TvDetailEmpty());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => const Right(testTvDetail));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvDetailCalled(tId)),
    expect: () => [
      TvDetailLoading(),
      TvDetailHasData(testTvDetail),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
      return OnTvDetailCalled(tId).props;
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvDetailCalled(tId)),
    expect: () => [
      TvDetailLoading(),
      TvDetailError('Server Failure'),
    ],
    verify: (bloc) => TvDetailLoading(),
  );
}
