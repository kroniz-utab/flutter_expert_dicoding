import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetSimilarTVShows usecase;
  late TvSimilarBloc tvBloc;

  const tId = 1;

  setUp(() {
    usecase = MockGetSimilarTVShows();
    tvBloc = TvSimilarBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TvSimilarEmpty());
  });

  blocTest<TvSimilarBloc, TvSimilarState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => Right(testTVList));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvSimilarCalled(tId)),
    expect: () => [
      TvSimilarLoading(),
      TvSimilarHasData(testTVList),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
      return OnTvSimilarCalled(tId).props;
    },
  );

  blocTest<TvSimilarBloc, TvSimilarState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvSimilarCalled(tId)),
    expect: () => [
      TvSimilarLoading(),
      TvSimilarError('Server Failure'),
    ],
    verify: (bloc) => TvSimilarLoading(),
  );

  blocTest<TvSimilarBloc, TvSimilarState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvSimilarCalled(tId)),
    expect: () => [
      TvSimilarLoading(),
      TvSimilarEmpty(),
    ],
  );
}
