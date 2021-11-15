// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
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
