import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TVLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVWatchlist(testTVTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertTVWatchlist(testTVTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVWatchlist(testTVTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertTVWatchlist(testTVTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTVWatchlist(testTVTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeTVWatchlist(testTVTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTVWatchlist(testTVTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeTVWatchlist(testTVTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTVShowById(tId))
          .thenAnswer((_) async => testTVMap);
      // act
      final result = await dataSource.getTVShowById(tId);
      // assert
      expect(result, testTVTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTVShowById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTVShowById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTVShow())
          .thenAnswer((_) async => [testTVMap]);
      // act
      final result = await dataSource.getWatchlistTVShow();
      // assert
      expect(result, [testTVTable]);
    });
  });

  group('cache now playing movies', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearTVCache('on the air'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheTVOnTheAir([testTVCache]);
      // assert
      verify(mockDatabaseHelper.clearTVCache('on the air'));
      verify(mockDatabaseHelper
          .insertTVCacheTransaction([testTVCache], 'on the air'));
    });

    test('should return list of movies from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getTVCacheMovies('on the air'))
          .thenAnswer((_) async => [testTVCacheMap]);
      // act
      final result = await dataSource.getCachedTVOnTheAir();
      // assert
      expect(result, [testTVCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getTVCacheMovies('on the air'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedTVOnTheAir();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
