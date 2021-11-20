import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetTVSeasonDetail usecase;
  late TvSeasonDetailBloc tvBloc;

  const tId = 1;
  const tSeason = 1;

  setUp(() {
    usecase = MockGetTVSeasonDetail();
    tvBloc = TvSeasonDetailBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TvSeasonDetailEmpty());
  });

  blocTest<TvSeasonDetailBloc, TvSeasonDetailState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId, tSeason))
          .thenAnswer((_) async => const Right(testTvSeason));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnSeasonDetailCalled(tId, tSeason)),
    expect: () => [
      TvSeasonDetailLoading(),
      TvSeasonDetailHasData(testTvSeason),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId, tSeason));
      return OnSeasonDetailCalled(tId, tSeason).props;
    },
  );

  blocTest<TvSeasonDetailBloc, TvSeasonDetailState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute(tId, tSeason))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnSeasonDetailCalled(tId, tSeason)),
    expect: () => [
      TvSeasonDetailLoading(),
      TvSeasonDetailError('Server Failure'),
    ],
    verify: (bloc) => TvSeasonDetailLoading(),
  );
}
