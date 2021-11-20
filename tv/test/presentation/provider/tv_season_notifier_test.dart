// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tv_season_notifier_test.mocks.dart';

@GenerateMocks([GetTVSeasonDetail])
void main() {
  late TVSeasonNotifier provider;
  late MockGetTVSeasonDetail mockGetTVSeasonDetail;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVSeasonDetail = MockGetTVSeasonDetail();
    provider = TVSeasonNotifier(getTVSeasonDetail: mockGetTVSeasonDetail)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;
  const tSeason = 1;

  void _arrangeUsecase() {
    when(mockGetTVSeasonDetail.execute(tId, tSeason))
        .thenAnswer((_) async => Right(testTvSeason));
  }

  group('Get tv season Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeasonDetail(tId, tSeason);
      // assert
      verify(mockGetTVSeasonDetail.execute(tId, tSeason));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchSeasonDetail(tId, tSeason);
      // assert
      expect(provider.dataState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeasonDetail(tId, tSeason);
      // assert
      expect(provider.dataState, RequestState.Loaded);
      expect(provider.data, testTvSeason);
      expect(listenerCallCount, 2);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVSeasonDetail.execute(tId, tSeason))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchSeasonDetail(tId, tSeason);
      // assert
      expect(provider.dataState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}