import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetTVOnTheAir usecase;
  late TvListBloc tvBloc;

  setUp(() {
    usecase = MockGetTVOnTheAir();
    tvBloc = TvListBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TvListEmpty());
  });

  blocTest<TvListBloc, TvListState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testTVList));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvShowListCalled()),
    expect: () => [
      TvListLoading(),
      TvListHasData(testTVList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnTvShowListCalled().props;
    },
  );

  blocTest<TvListBloc, TvListState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvShowListCalled()),
    expect: () => [
      TvListLoading(),
      TvListError('Server Failure'),
    ],
    verify: (bloc) => TvListLoading(),
  );

  blocTest<TvListBloc, TvListState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTvShowListCalled()),
    expect: () => [
      TvListLoading(),
      TvListEmpty(),
    ],
  );
}
