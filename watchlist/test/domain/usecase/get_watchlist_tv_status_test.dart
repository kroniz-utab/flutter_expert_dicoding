import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetWatchlistTVStatus usecase;
  late MockTVRepository repository;

  setUp(() {
    repository = MockTVRepository();
    usecase = GetWatchlistTVStatus(repository);
  });

  group('Get watchlist TV Show status test', () {
    group('execute', () {
      test('should get status of Tv Show watchlist from the repository',
          () async {
        // arrange
        when(repository.isAddedToWatchlist(1)).thenAnswer((_) async => true);
        // act
        final result = await usecase.execute(1);
        // assert
        expect(result, true);
      });
    });
  });
}
