import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  const watchlistAddSuccessMessage = 'Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  late MockGetWatchlistTVShows getWatchlistTVShows;
  late MockGetWatchlistTVStatus getWatchlistTVStatus;
  late MockSaveTVWatchList saveTVWatchList;
  late MockRemoveTVWatchlist removeTVWatchlist;
  late TvWatchlistBloc watchlistBloc;

  setUp(() {
    getWatchlistTVShows = MockGetWatchlistTVShows();
    getWatchlistTVStatus = MockGetWatchlistTVStatus();
    saveTVWatchList = MockSaveTVWatchList();
    removeTVWatchlist = MockRemoveTVWatchlist();
    watchlistBloc = TvWatchlistBloc(
      getWatchlistTVShows,
      getWatchlistTVStatus,
      saveTVWatchList,
      removeTVWatchlist,
    );
  });

  test('initial state should be initial state', () {
    expect(watchlistBloc.state, TvWatchlistInitial());
  });

  group(
    'this test for get watchlist tv, ',
    () {
      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'should emit [Loading, HasData] when watchlist data is gotten succesfully',
        build: () {
          when(getWatchlistTVShows.execute())
              .thenAnswer((_) async => Right([testWatchlistTV]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvWatchlist()),
        expect: () => [
          TvWatchlistLoading(),
          TvWatchlistHasData([testWatchlistTV]),
        ],
        verify: (bloc) {
          verify(getWatchlistTVShows.execute());
          return OnFetchTvWatchlist().props;
        },
      );

      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(getWatchlistTVShows.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvWatchlist()),
        expect: () => [
          TvWatchlistLoading(),
          TvWatchlistError('Server Failure'),
        ],
        verify: (bloc) => TvWatchlistLoading(),
      );

      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'should emit [Loading, Empty] when get watchlist data is empty',
        build: () {
          when(getWatchlistTVShows.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvWatchlist()),
        expect: () => [
          TvWatchlistLoading(),
          TvWatchlistEmpty(),
        ],
      );
    },
  );

  group(
    'this test for get watchlist status,',
    () {
      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'should get true when the watchlist status is true',
        build: () {
          when(getWatchlistTVStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchTvWatchlistStatus(testTvDetail.id)),
        expect: () => [
          TvIsAddedToWatchlist(true),
        ],
        verify: (bloc) {
          verify(getWatchlistTVStatus.execute(testTvDetail.id));
          return FetchTvWatchlistStatus(testTvDetail.id).props;
        },
      );

      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'should get false when the watchlist status is false',
        build: () {
          when(getWatchlistTVStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchTvWatchlistStatus(testTvDetail.id)),
        expect: () => [
          TvIsAddedToWatchlist(false),
        ],
        verify: (bloc) {
          verify(getWatchlistTVStatus.execute(testTvDetail.id));
          return FetchTvWatchlistStatus(testTvDetail.id).props;
        },
      );
    },
  );

  group(
    'this test for add and remove watchlist,',
    () {
      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'should update watchlist status when add watchlist is success',
        build: () {
          when(saveTVWatchList.execute(testTvDetail))
              .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddTvToWatchlist(testTvDetail)),
        expect: () => [
          TvWatchlistMessage(watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(saveTVWatchList.execute(testTvDetail));
          return AddTvToWatchlist(testTvDetail).props;
        },
      );

      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'should throw failure message status when add watchlist is unsuccessful',
        build: () {
          when(saveTVWatchList.execute(testTvDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddTvToWatchlist(testTvDetail)),
        expect: () => [
          TvWatchlistError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveTVWatchList.execute(testTvDetail));
          return AddTvToWatchlist(testTvDetail).props;
        },
      );

      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'should update watchlist status when remove watchlist is success',
        build: () {
          when(removeTVWatchlist.execute(testTvDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(RemoveTvFromWatchlist(testTvDetail)),
        expect: () => [
          TvWatchlistMessage(watchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(removeTVWatchlist.execute(testTvDetail));
          return RemoveTvFromWatchlist(testTvDetail).props;
        },
      );

      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'should throw failure message status when remove watchlist is unsuccessful',
        build: () {
          when(removeTVWatchlist.execute(testTvDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(RemoveTvFromWatchlist(testTvDetail)),
        expect: () => [
          TvWatchlistError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeTVWatchlist.execute(testTvDetail));
          return RemoveTvFromWatchlist(testTvDetail).props;
        },
      );
    },
  );
}
