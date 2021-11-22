// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/data/models/tv_models/tv_model.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockRemoteDataSource;
  late MockTVLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVRemoteDataSource();
    mockLocalDataSource = MockTVLocalDataSource();
    repository = TVRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTVModelList = <TVModel>[testTVModel];
  final tTVList = <TV>[testTVEntity];

  group('tv show on the air', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVOnTheAir())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getTVOnTheAir();
      // assert
      verify(mockRemoteDataSource.getTVOnTheAir());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVOnTheAir()).thenThrow(ServerException());
      // act
      final result = await repository.getTVOnTheAir();
      // assert
      verify(mockRemoteDataSource.getTVOnTheAir());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVOnTheAir())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVOnTheAir();
      // assert
      verify(mockRemoteDataSource.getTVOnTheAir());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return TLS Exception when certificatie not valid', () async {
      // arrange
      when(mockRemoteDataSource.getTVOnTheAir())
          .thenThrow(TlsException('test'));
      // act
      final result = await repository.getTVOnTheAir();
      // assert
      verify(mockRemoteDataSource.getTVOnTheAir());
      expect(result, equals(Left(CommonFailure('Certificate not valid test'))));
    });

    test('should throw CommonFailure when catch error', () async {
      // arrange
      when(mockRemoteDataSource.getTVOnTheAir()).thenThrow('failure');
      // act
      final result = await repository.getTVOnTheAir();
      // assert
      expect(result, equals(Left(CommonFailure('failure'))));
    });
  });

  group('Popular tv show', () {
    test('should return tv show list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVShows())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getPopularTVShows();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTVShows();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVShows())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVShows();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    test('should return TLS Exception when certificatie not valid', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVShows())
          .thenThrow(TlsException('test'));
      // act
      final result = await repository.getPopularTVShows();
      // assert
      verify(mockRemoteDataSource.getPopularTVShows());
      expect(result, equals(Left(CommonFailure('Certificate not valid test'))));
    });

    test('should throw CommonFailure when catch error', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVShows()).thenThrow('failure');
      // act
      final result = await repository.getPopularTVShows();
      // assert
      expect(result, equals(Left(CommonFailure('failure'))));
    });
  });

  group('Top Rated tv show', () {
    test('should return tv show list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVShows())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getTopRatedTVShows();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTVShows();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVShows())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVShows();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    test('should return TLS Exception when certificatie not valid', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVShows())
          .thenThrow(TlsException('test'));
      // act
      final result = await repository.getTopRatedTVShows();
      // assert
      verify(mockRemoteDataSource.getTopRatedTVShows());
      expect(result, equals(Left(CommonFailure('Certificate not valid test'))));
    });

    test('should throw CommonFailure when catch error', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVShows()).thenThrow('failure');
      // act
      final result = await repository.getTopRatedTVShows();
      // assert
      expect(result, equals(Left(CommonFailure('failure'))));
    });
  });

  group('Get tv show Detail', () {
    const tId = 1;

    test(
        'should return tv show data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenAnswer((_) async => testTvDetailResponse);
      // act
      final result = await repository.getTVShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTVShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return TLS Exception when certificatie not valid', () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenThrow(TlsException('test'));
      // act
      final result = await repository.getTVShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Left(CommonFailure('Certificate not valid test'))));
    });

    test('should throw CommonFailure when catch error', () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenThrow('failure');
      // act
      final result = await repository.getTVShowDetail(tId);
      // assert
      expect(result, equals(Left(CommonFailure('failure'))));
    });
  });

  group('Get tv season Detail', () {
    const tId = 1;
    const season = 1;

    test(
        'should return tv show data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, season))
          .thenAnswer((_) async => testTvSeasonResponse);
      // act
      final result = await repository.getTVSeasonDetail(tId, season);
      // assert
      verify(mockRemoteDataSource.getSeasonDetail(tId, season));
      expect(result, equals(Right(testTvSeason)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, season))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVSeasonDetail(tId, season);
      // assert
      verify(mockRemoteDataSource.getSeasonDetail(tId, season));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, season))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeasonDetail(tId, season);
      // assert
      verify(mockRemoteDataSource.getSeasonDetail(tId, season));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return TLS Exception when certificatie not valid', () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, season))
          .thenThrow(TlsException('test'));
      // act
      final result = await repository.getTVSeasonDetail(tId, season);
      // assert
      verify(mockRemoteDataSource.getSeasonDetail(tId, season));
      expect(result, equals(Left(CommonFailure('Certificate not valid test'))));
    });

    test('should throw CommonFailure when catch error', () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, season))
          .thenThrow('failure');
      // act
      final result = await repository.getTVSeasonDetail(tId, season);
      // assert
      expect(result, equals(Left(CommonFailure('failure'))));
    });
  });

  group('Get tv show Recommendations', () {
    final tTVList = <TVModel>[];
    const tId = 1;

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTVList);
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTVList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return TLS Exception when certificatie not valid', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(TlsException('test'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(CommonFailure('Certificate not valid test'))));
    });

    test('should throw CommonFailure when catch error', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId)).thenThrow('failure');
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      expect(result, equals(Left(CommonFailure('failure'))));
    });
  });

  group('Get tv show similar', () {
    final tTVList = <TVModel>[];
    const tId = 1;

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getSimilarTVShows(tId))
          .thenAnswer((_) async => tTVList);
      // act
      final result = await repository.getSimilarTVShows(tId);
      // assert
      verify(mockRemoteDataSource.getSimilarTVShows(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTVList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSimilarTVShows(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSimilarTVShows(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getSimilarTVShows(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSimilarTVShows(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSimilarTVShows(tId);
      // assert
      verify(mockRemoteDataSource.getSimilarTVShows(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return TLS Exception when certificatie not valid', () async {
      // arrange
      when(mockRemoteDataSource.getSimilarTVShows(tId))
          .thenThrow(TlsException('test'));
      // act
      final result = await repository.getSimilarTVShows(tId);
      // assert
      verify(mockRemoteDataSource.getSimilarTVShows(tId));
      expect(result, equals(Left(CommonFailure('Certificate not valid test'))));
    });

    test('should throw CommonFailure when catch error', () async {
      // arrange
      when(mockRemoteDataSource.getSimilarTVShows(tId)).thenThrow('failure');
      // act
      final result = await repository.getSimilarTVShows(tId);
      // assert
      expect(result, equals(Left(CommonFailure('failure'))));
    });
  });

  group('Seach tv', () {
    const tQuery = 'gambit';

    test('should return tv show list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVShows(tQuery))
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.searchTVShows(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVShows(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTVShows(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVShows(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTVShows(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    test('should return TLS Exception when certificatie not valid', () async {
      // arrange
      when(mockRemoteDataSource.searchTVShows(tQuery))
          .thenThrow(TlsException('test'));
      // act
      final result = await repository.searchTVShows(tQuery);
      // assert
      verify(mockRemoteDataSource.searchTVShows(tQuery));
      expect(result, equals(Left(CommonFailure('Certificate not valid test'))));
    });

    test('should throw CommonFailure when catch error', () async {
      // arrange
      when(mockRemoteDataSource.searchTVShows(tQuery)).thenThrow('failure');
      // act
      final result = await repository.searchTVShows(tQuery);
      // assert
      expect(result, equals(Left(CommonFailure('failure'))));
    });
  });

  group('watchlist test', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getTVShowById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });

    test('should return tv watchlist', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTVShow())
          .thenAnswer((_) async => [testTVTable]);
      // act
      final result = await repository.getWatchListTVShow();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTV]);
    });

    test('should return success message when saving is successful', () async {
      // arrange
      when(mockLocalDataSource.insertTVWatchlist(testTVTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving is unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertTVWatchlist(testTVTable))
          .thenThrow(DatabaseException('Failed to add Watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add Watchlist')));
    });

    test('should return success message when remove is successful', () async {
      // arrange
      when(mockLocalDataSource.removeTVWatchlist(testTVTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove is unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeTVWatchlist(testTVTable))
          .thenThrow(DatabaseException('Failed to Remove from watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to Remove from watchlist')));
    });
  });
}
