import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTVShows])
void main() {
  late MockSearchTVShows mockSearchTVShows;
  late SearchTvBloc searchBloc;

  setUp(() {
    mockSearchTVShows = MockSearchTVShows();
    searchBloc = SearchTvBloc(mockSearchTVShows);
  });

  final testTVEntity = TV(
    backdropPath: '/path.jpg',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 9.9,
    posterPath: '/path.jpg',
    voteAverage: 9.9,
    voteCount: 1,
  );
  final tTvList = <TV>[testTVEntity];
  const tQuery = 'gambit';

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchTvEmpty());
  });

  blocTest<SearchTvBloc, SearchTvState>(
    'should emit [HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvChange(tQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchTvHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTVShows.execute(tQuery));
      return OnQueryTvChange(tQuery).props;
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'should emit [Error] lwhen get search is unsuccessful',
    build: () {
      when(mockSearchTVShows.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvChange(tQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVShows.execute(tQuery));
      return SearchTvLoading().props;
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'should emit [empty] when get search is empty',
    build: () {
      when(mockSearchTVShows.execute(tQuery))
          .thenAnswer((_) async => const Right([]));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvChange(tQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchTvEmpty(),
    ],
    verify: (bloc) {
      verify(mockSearchTVShows.execute(tQuery));
    },
  );
}
