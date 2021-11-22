import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../dummy_data/dummy_objects_movie.dart';
import '../../../dummy_data/dummy_objects_tv.dart';

void main() {
  late DatabaseHelper dbHelper;

  setUp(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    dbHelper = DatabaseHelper();
  });

  test('database should be initialized properly', () async {
    // arrange
    // act
    final result = await dbHelper.database;

    // assert
    expect(result, isNotNull);
  });

  group('function test database', () {
    test('movie related function must be work properly', () async {
      // arrange
      dbHelper.setDatabase(
        await openDatabase(
          inMemoryDatabasePath,
          version: 1,
          onCreate: (db, version) async {
            await db.execute('''
              CREATE TABLE  movieWatchlist (
                id INTEGER PRIMARY KEY,
                title TEXT,
                overview TEXT,
                posterPath TEXT
              );
            ''');
          },
        ),
      );
      // act
      final testAdd = await dbHelper.insertMovieWatchlist(testMovieTable);
      final testGetById = await dbHelper.getMovieById(1);
      final testGetList = await dbHelper.getWatchlistMovies();
      final testRemove = await dbHelper.removeMovieWatchlist(testMovieTable);
      await deleteDatabase(inMemoryDatabasePath);
      // assert
      expect(testAdd, 1);
      expect(testGetById, testMovieTable.toJson());
      expect(testGetList, [testMovieMap]);
      expect(testRemove, 1);
    });

    test('movie-cache related function must be working properly', () async {
      // arrange
      dbHelper.setDatabase(
        await openDatabase(
          inMemoryDatabasePath,
          version: 1,
          onCreate: (db, version) async {
            await db.execute('''
              CREATE TABLE  movieCache (
                  id INTEGER PRIMARY KEY,
                  title TEXT,
                  overview TEXT,
                  posterPath TEXT,
                  category TEXT
                );
              ''');
          },
        ),
      );
      // act
      await dbHelper.insertMoviesCacheTransaction([testMovieTable], 'movie');
      final testGetMovieByCategory = await dbHelper.getMoviesCache('movie');
      final testRemoveMovieCache = await dbHelper.clearMoviesCache('movie');
      await deleteDatabase(inMemoryDatabasePath);
      // assert
      expect(
        testGetMovieByCategory,
        [
          {
            'id': 1,
            'title': 'title',
            'overview': 'overview',
            'posterPath': '/path.jpg',
            'category': 'movie'
          }
        ],
      );
      expect(testRemoveMovieCache, 1);
    });

    test('tv related function must be working properly', () async {
      // arrange
      dbHelper.setDatabase(
        await openDatabase(
          inMemoryDatabasePath,
          version: 1,
          onCreate: (db, version) async {
            await db.execute('''
              CREATE TABLE  tvWatchlist (
                id INTEGER PRIMARY KEY,
                name TEXT,
                overview TEXT,
                posterPath TEXT
              );
            ''');
          },
        ),
      );
      // act
      final testTVInsert = await dbHelper.insertTVWatchlist(testTVTable);
      final testTvGetByID = await dbHelper.getTVShowById(1);
      final testGetTvList = await dbHelper.getWatchlistTVShow();
      final testTvRemove = await dbHelper.removeTVWatchlist(testTVTable);
      await deleteDatabase(inMemoryDatabasePath);
      // assert
      expect(testTVInsert, 1);
      expect(testTvGetByID, testTVTable.toJson());
      expect(testGetTvList, [testTVMap]);
      expect(testTvRemove, 1);
    });

    test('tv-cache related function must be working properly', () async {
      // arrange
      dbHelper.setDatabase(
        await openDatabase(
          inMemoryDatabasePath,
          version: 1,
          onCreate: (db, version) async {
            await db.execute('''
              CREATE TABLE  tvCache (
                  id INTEGER PRIMARY KEY,
                  name TEXT,
                  overview TEXT,
                  posterPath TEXT,
                  category TEXT
                );
              ''');
          },
        ),
      );
      // act
      await dbHelper.insertTVCacheTransaction([testTVTable], 'tvshow');
      final testGetTvById = await dbHelper.getTVCache('tvshow');
      final testTvRemove = await dbHelper.clearTVCache('tvshow');
      await deleteDatabase(inMemoryDatabasePath);
      // assert
      expect(
        testGetTvById,
        [
          {
            'id': 1,
            'name': 'name',
            'overview': 'overview',
            'posterPath': '/path.jpg',
            'category': 'tvshow'
          }
        ],
      );
      expect(testTvRemove, 1);
    });
  });
}
