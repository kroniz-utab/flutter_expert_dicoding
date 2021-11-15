// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTVSeasonDetail usecase;
  late MockTVRepository repository;

  setUp(() {
    repository = MockTVRepository();
    usecase = GetTVSeasonDetail(repository);
  });

  const tId = 1;
  const tSeason = 1;

  group('Get Detail TV Show\'s Season test', () {
    group('execute', () {
      test('should get movie detail from the repository', () async {
        // arrange
        when(repository.getTVSeasonDetail(tId, tSeason))
            .thenAnswer((_) async => Right(testTvSeason));
        // act
        final result = await usecase.execute(tId, tSeason);
        // assert
        expect(result, Right(testTvSeason));
      });
    });
  });
}
