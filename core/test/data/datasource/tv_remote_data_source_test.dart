import 'dart:convert';

import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/tv_remote_data_source.dart';
import 'package:core/data/models/tv_models/season_detail_model.dart';
import 'package:core/data/models/tv_models/tv_detail_model.dart';
import 'package:core/data/models/tv_models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = TVRemoteDataSourceImpl(client: mockIOClient);
  });

  group('get On The Air TV Shows', () {
    final tTVList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_on_the_air_response.json')))
        .tvList;

    test('should return list of TV Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_on_the_air_response.json'), 200));
      // act
      final result = await dataSource.getTVOnTheAir();
      // assert
      expect(result, equals(tTVList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVOnTheAir();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TVShow', () {
    final tPopularList =
        TvResponse.fromJson(json.decode(readJson('dummy_data/popular_tv.json')))
            .tvList;

    test('should return list of Popular TV Show when response is success (200)',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tv.json'), 200));
      // act
      final result = await dataSource.getPopularTVShows();
      // assert
      expect(result, tPopularList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTVShows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TV Show', () {
    final tTVList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv_show.json')))
        .tvList;

    test('should return list of TV Show when response code is 200 ', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/top_rated_tv_show.json'), 200));
      // act
      final result = await dataSource.getTopRatedTVShows();
      // assert
      expect(result, tTVList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTVShows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TV detail', () {
    const tId = 1;
    final tTVDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return TV detail when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTVDetail(tId);
      // assert
      expect(result, equals(tTVDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTVList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendation.json')))
        .tvList;
    const tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendation.json'), 200));
      // act
      final result = await dataSource.getTvRecommendations(tId);
      // assert
      expect(result, equals(tTVList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get similar TV Shows', () {
    final tTVList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/similar_tv_shows.json')))
        .tvList;
    const tId = 1;

    test('should return list of similar tv Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/$tId/similar?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/similar_tv_shows.json'), 200));
      // act
      final result = await dataSource.getSimilarTVShows(tId);
      // assert
      expect(result, equals(tTVList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/$tId/similar?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSimilarTVShows(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = TvResponse.fromJson(
            json.decode(readJson('dummy_data/search_gambit_series.json')))
        .tvList;
    const tQuery = 'gambit';

    test('should return list of tv show when response code is 200', () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_gambit_series.json'), 200));
      // act
      final result = await dataSource.searchTVShows(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTVShows(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('get TV Season detail', () {
    const tId = 1;
    const seasonNumber = 1;
    final tTVSeasonDetail = SeasonDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_season_detail.json')));

    test('should return TV detail when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(
              Uri.parse('$BASE_URL/tv/$tId/season/$seasonNumber?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_season_detail.json'), 200));
      // act
      final result = await dataSource.getSeasonDetail(tId, seasonNumber);
      // assert
      expect(result, equals(tTVSeasonDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(
              Uri.parse('$BASE_URL/tv/$tId/season/$seasonNumber?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeasonDetail(tId, seasonNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
