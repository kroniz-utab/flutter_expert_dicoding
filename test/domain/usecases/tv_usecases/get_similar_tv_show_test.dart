import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_similar_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSimilarTVShows usecase;
  late MockTVRepository repository;

  setUp(() {
    repository = MockTVRepository();
    usecase = GetSimilarTVShows(repository);
  });

  final tId = 1;
  final tTVShow = <TV>[];

  group('Get Similar TV Show test', () {
    group('execute', () {
      test('should get list of Tv Show recommendations from the repository',
          () async {
        // arrange
        when(repository.getSimilarTVShows(tId))
            .thenAnswer((_) async => Right(tTVShow));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tTVShow));
      });
    });
  });
}
