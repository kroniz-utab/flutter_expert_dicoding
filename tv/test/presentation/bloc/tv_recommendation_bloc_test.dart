import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetTVRecommendations usecase;
  late TvRecommendationBloc tvBloc;

  const tId = 1;

  setUp(() {
    usecase = MockGetTVRecommendations();
    tvBloc = TvRecommendationBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TvRecommendationEmpty());
  });

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => Right(testTVList));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvRecommendationCalled(tId)),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationHasData(testTVList),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
      return OnTvRecommendationCalled(tId).props;
    },
  );

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvRecommendationCalled(tId)),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationError('Server Failure'),
    ],
    verify: (bloc) => TvRecommendationLoading(),
  );

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvRecommendationCalled(tId)),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationEmpty(),
    ],
  );
}
