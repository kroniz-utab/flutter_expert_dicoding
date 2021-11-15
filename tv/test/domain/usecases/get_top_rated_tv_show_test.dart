import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTopRatedTVShows usecase;
  late MockTVRepository repository;

  setUp(() {
    repository = MockTVRepository();
    usecase = GetTopRatedTVShows(repository);
  });

  final tTvShow = <TV>[];

  group('Get Top Rated TV Show test', () {
    group('execute', () {
      test(
          'should get list of TV Show from the repository when execute function is called',
          () async {
        // arrange
        when(repository.getTopRatedTVShows())
            .thenAnswer((_) async => Right(tTvShow));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvShow));
      });
    });
  });
}
