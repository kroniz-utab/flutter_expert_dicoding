import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVRecommendations usecase;
  late MockTVRepository repository;

  setUp(() {
    repository = MockTVRepository();
    usecase = GetTVRecommendations(repository);
  });

  final tId = 1;
  final tTVShow = <TV>[];

  group('Get Similar TV Show test', () {
    group('execute', () {
      test('should get list of Tv Show recommendations from the repository',
          () async {
        // arrange
        when(repository.getTvRecommendations(tId))
            .thenAnswer((_) async => Right(tTVShow));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tTVShow));
      });
    });
  });
}
