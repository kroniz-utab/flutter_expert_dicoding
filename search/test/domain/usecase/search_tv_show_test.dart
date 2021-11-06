import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import '../../../lib/domain/usecase/search_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late SearchTVShows usecase;
  late MockTVRepository repository;

  setUp(() {
    repository = MockTVRepository();
    usecase = SearchTVShows(repository);
  });

  final tTv = <TV>[];
  const tQuery = 'gambit';

  group('search TV Show test', () {
    group('execute', () {
      test('should get list Tv Show watchlist from the repository', () async {
        // arrange
        when(repository.searchTVShows(tQuery))
            .thenAnswer((_) async => Right(tTv));
        // act
        final result = await usecase.execute(tQuery);
        // assert
        expect(result, Right(tTv));
      });
    });
  });
}
