import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVShowDetail usecase;
  late MockTVRepository repository;

  setUp(() {
    repository = MockTVRepository();
    usecase = GetTVShowDetail(repository);
  });

  final tId = 1;

  group('Get Detail TV Show test', () {
    group('execute', () {
      test('should get movie detail from the repository', () async {
        // arrange
        when(repository.getTVShowDetail(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(testTvDetail));
      });
    });
  });
}
