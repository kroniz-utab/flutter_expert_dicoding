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
  late FakePopularMovieBloc fakeBloc;

  setUp(() {
    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
    fakeBloc = FakePopularMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>(
      create: (context) => fakeBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>(
      create: (context) => fakeBloc,
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(PopularMoviesPage()),
    movieDetailRoutes: (context) => FakeDestination(),
  };

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(MoviePopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(MoviePopularHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(MoviePopularError('error'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when empty',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(MoviePopularEmpty());

    final textFinder = find.byKey(Key('empty_data'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Tapping on item should go to detail page', (tester) async {
    when(() => fakeBloc.state).thenReturn(MoviePopularHasData(testMovieList));

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
    expect(find.byKey(Key('this_is_popular_page')), findsOneWidget);
    expect(find.byKey(Key('fakeHome')), findsNothing);

    await tester.tap(find.byKey(Key('card_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(Duration(seconds: 1));
    }

    expect(find.byKey(Key('this_is_popular_page')), findsNothing);
  });
}
