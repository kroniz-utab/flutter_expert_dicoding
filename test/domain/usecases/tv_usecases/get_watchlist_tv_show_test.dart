import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_watchlist_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTVShows usecase;
  late MockTVRepository repository;

  setUp(() {
    repository = MockTVRepository();
    usecase = GetWatchlistTVShows(repository);
  });

  group('Get watchlist TV Show test', () {
    group('execute', () {
      test('should get list of Tv Show watchlist from the repository',
          () async {
        // arrange
        when(repository.getWatchListTVShow())
            .thenAnswer((_) async => Right(testTVList));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(testTVList));
      });
    });
  });
}
