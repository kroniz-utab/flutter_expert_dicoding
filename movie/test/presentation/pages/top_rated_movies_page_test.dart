// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects_movie.dart';
import 'app_helper.dart';
import 'helper/fake_pages_helper.dart';

void main() {
  late FakeTopRatedMovieBloc fakeBloc;

  setUp(() {
    registerFallbackValue(FakeTopRatedMovieEvent());
    registerFallbackValue(FakeTopRatedMovieState());
    fakeBloc = FakeTopRatedMovieBloc();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>(
      create: (context) => fakeBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>(
      create: (context) => fakeBloc,
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(TopRatedMoviesPage()),
    movieDetailRoutes: (context) => FakeDestination(),
  };

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(MovieTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_createTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(MovieTopRatedHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(MovieTopRatedError('error'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_createTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when empty',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(MovieTopRatedEmpty());

    final textFinder = find.byKey(Key('empty_data'));

    await tester.pumpWidget(_createTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Tapping on item should go to detail page', (tester) async {
    when(() => fakeBloc.state).thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(Duration(seconds: 1));
    }

    final movieCardFinder = find.byType(MovieCard);
    expect(movieCardFinder, findsOneWidget);
    expect(find.byKey(Key('card_0')), findsOneWidget);
    expect(find.byKey(Key('this_is_top_rated')), findsOneWidget);
    expect(find.byKey(Key('fakeHome')), findsNothing);

    await tester.tap(find.byKey(Key('card_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(Duration(seconds: 1));
    }

    expect(find.byKey(Key('this_is_top_rated')), findsNothing);
  });
}
