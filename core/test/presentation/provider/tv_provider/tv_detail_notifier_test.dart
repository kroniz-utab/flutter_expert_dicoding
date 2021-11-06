// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/usecases/tv_usecases/get_similar_tv_shows.dart';
import 'package:core/domain/usecases/tv_usecases/get_tv_recommendations.dart';
import 'package:core/domain/usecases/tv_usecases/get_tv_show_detail.dart';
import 'package:core/domain/usecases/tv_usecases/get_watchlist_tv_status.dart';
import 'package:core/domain/usecases/tv_usecases/remove_tv_watchlist.dart';
import 'package:core/domain/usecases/tv_usecases/save_tv_watchlist.dart';
import 'package:core/presentation/provider/tv_provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTVShowDetail,
  GetTVRecommendations,
  GetWatchlistTVStatus,
  GetSimilarTVShows,
  SaveTVWatchList,
  RemoveTVWatchlist,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTVShowDetail mockGetTVShowDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetSimilarTVShows mockGetSimilarTVShows;
  late MockGetWatchlistTVStatus mockGetWatchlistTVStatus;
  late MockSaveTVWatchList mockSaveTVWatchList;
  late MockRemoveTVWatchlist mockRemoveTVWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVShowDetail = MockGetTVShowDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetWatchlistTVStatus = MockGetWatchlistTVStatus();
    mockGetSimilarTVShows = MockGetSimilarTVShows();
    mockSaveTVWatchList = MockSaveTVWatchList();
    mockRemoveTVWatchlist = MockRemoveTVWatchlist();
    provider = TvDetailNotifier(
      getTVShowDetail: mockGetTVShowDetail,
      getTVRecommendations: mockGetTVRecommendations,
      getSimilarTVShows: mockGetSimilarTVShows,
      getWatchlistTVStatus: mockGetWatchlistTVStatus,
      removeTVWatchlist: mockRemoveTVWatchlist,
      saveTVWatchList: mockSaveTVWatchList,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;
  final tTVList = <TV>[testTVEntity];

  void _arrangeUsecase() {
    when(mockGetTVShowDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTVRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTVList));
    when(mockGetSimilarTVShows.execute(tId))
        .thenAnswer((_) async => Right(tTVList));
  }

  group('Get tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchDetailTVShow(tId);
      // assert
      verify(mockGetTVShowDetail.execute(tId));
      verify(mockGetTVRecommendations.execute(tId));
      verify(mockGetSimilarTVShows.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchDetailTVShow(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchDetailTVShow(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShow, testTvDetail);
      expect(listenerCallCount, 4);
    });

    test('should change recommendation tvs when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchDetailTVShow(tId);
      // assert
      expect(provider.tvRecommendationsState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTVList);
      expect(listenerCallCount, 4);
    });

    test('should change similar tvs when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchDetailTVShow(tId);
      // assert
      expect(provider.similarTvState, RequestState.Loaded);
      expect(provider.similarTVShows, tTVList);
      expect(listenerCallCount, 4);
    });
  });

  group('Get tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchDetailTVShow(tId);
      // assert
      verify(mockGetTVRecommendations.execute(tId));
      expect(provider.tvRecommendations, tTVList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchDetailTVShow(tId);
      // assert
      expect(provider.tvRecommendationsState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTVList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTVShowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      when(mockGetSimilarTVShows.execute(tId))
          .thenAnswer((realInvocation) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchDetailTVShow(tId);
      // assert
      expect(provider.tvRecommendationsState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Get similar TV', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchDetailTVShow(tId);
      // assert
      verify(mockGetSimilarTVShows.execute(tId));
      expect(provider.similarTVShows, tTVList);
    });

    test('should update similar state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchDetailTVShow(tId);
      // assert
      expect(provider.similarTvState, RequestState.Loaded);
      expect(provider.similarTVShows, tTVList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTVShowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTVList));
      when(mockGetSimilarTVShows.execute(tId))
          .thenAnswer((realInvocation) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchDetailTVShow(tId);
      // assert
      expect(provider.similarTvState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistTVStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedtoWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveTVWatchList.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistTVStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockSaveTVWatchList.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveTVWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistTVStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvDetail);
      // assert
      verify(mockRemoveTVWatchlist.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveTVWatchList.execute(testTvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistTVStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockGetWatchlistTVStatus.execute(testTvDetail.id));
      expect(provider.isAddedtoWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveTVWatchList.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistTVStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVShowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTVList));
      when(mockGetSimilarTVShows.execute(tId))
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchDetailTVShow(tId);
      // assert
      expect(provider.tvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
