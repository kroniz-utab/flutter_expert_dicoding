// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'top_rated_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTVShows])
void main() {
  late MockGetTopRatedTVShows mockGetTopRatedTVShows;
  late TopRatedTVNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTVShows = MockGetTopRatedTVShows();
    notifier = TopRatedTVNotifier(getTopRatedTVShows: mockGetTopRatedTVShows)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTVList = <TV>[testTVEntity];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTVShows.execute())
        .thenAnswer((_) async => Right(tTVList));
    // act
    notifier.fetchTopRatedTVShows();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv show data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTVShows.execute())
        .thenAnswer((_) async => Right(tTVList));
    // act
    await notifier.fetchTopRatedTVShows();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvList, tTVList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTVShows.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTVShows();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
