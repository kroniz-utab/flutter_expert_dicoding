import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_popular_tv_show.dart';
import 'package:ditonton/presentation/provider/tv_provider/popular_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTVShows])
void main() {
  late MockGetPopularTVShows mockGetPopularTVShows;
  late PopularTVNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTVShows = MockGetPopularTVShows();
    notifier = PopularTVNotifier(getPopularTVShows: mockGetPopularTVShows)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTVList = <TV>[testTVEntity];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTVShows.execute())
        .thenAnswer((_) async => Right(tTVList));
    // act
    notifier.fetchPopularTVShows();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTVShows.execute())
        .thenAnswer((_) async => Right(tTVList));
    // act
    await notifier.fetchPopularTVShows();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvShows, tTVList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTVShows.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTVShows();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
