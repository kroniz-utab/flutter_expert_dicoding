import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeasonDetail usecase;
  late MockTVRepository repository;

  setUp(() {
    repository = MockTVRepository();
    usecase = GetTVSeasonDetail(repository);
  });

  final tId = 1;
  final tSeason = 1;

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
