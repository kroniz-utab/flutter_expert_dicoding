import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects_movie.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import 'app_helper.dart';
import 'helper/pages_test_helper.dart';

void main() {
  late FakeMovieWatchlistBloc movieBloc;
  late FakeTVWatchlistBloc tvBloc;

  setUp(() {
    registerFallbackValue(FakeMovieWatchlistEvent());
    registerFallbackValue(FakeMovieWatchlistState());
    movieBloc = FakeMovieWatchlistBloc();

    registerFallbackValue(FakeTVWatchlistEvent());
    registerFallbackValue(FakeTVWatchlistState());
    tvBloc = FakeTVWatchlistBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => movieBloc,
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (context) => tvBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => movieBloc,
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (context) => tvBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) =>
        _createAnotherTestableWidget(const WatchlistMoviesPage()),
    movieDetailRoutes: (context) => const FakeDestination(),
    tvDetailRoutes: (context) => const FakeDestination(),
  };

  testWidgets(
    "Page should display progress when loading",
    (WidgetTester tester) async {
      when(() => movieBloc.state).thenReturn(MovieWatchlistLoading());
      when(() => tvBloc.state).thenReturn(TvWatchlistLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester
          .pumpWidget(_createTestableWidget(const WatchlistMoviesPage()));

      expect(progressBarFinder, findsNWidgets(2));
    },
  );

  testWidgets(
    "page should display error message when error",
    (WidgetTester tester) async {
      when(() => movieBloc.state).thenReturn(MovieWatchlistError('error'));
      when(() => tvBloc.state).thenReturn(TvWatchlistError('error'));

      final errorKeyFinder = find.byKey(const Key('error_message'));

      await tester
          .pumpWidget(_createTestableWidget(const WatchlistMoviesPage()));

      expect(errorKeyFinder, findsNWidgets(2));
    },
  );

  testWidgets(
    "page should provide empty key when empty",
    (WidgetTester tester) async {
      when(() => movieBloc.state).thenReturn(MovieWatchlistEmpty());
      when(() => tvBloc.state).thenReturn(TvWatchlistEmpty());

      final emptyKeyFinder = find.byKey(const Key('empty_data'));

      await tester
          .pumpWidget(_createTestableWidget(const WatchlistMoviesPage()));

      expect(emptyKeyFinder, findsNWidgets(2));
    },
  );

  testWidgets(
    "Tapping on card movie should go to movie detail page",
    (WidgetTester tester) async {
      when(() => movieBloc.state)
          .thenReturn(MovieWatchlistHasData(testMovieList));
      when(() => tvBloc.state).thenReturn(TvWatchlistHasData(testTVList));

      await tester.pumpWidget(MaterialApp(
        routes: routes,
      ));

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);

      await tester.tap(find.byKey(const Key('fakeHome')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('this_is_watchlist')), findsOneWidget);
      expect(find.byKey(const Key('movie_card_0')), findsOneWidget);
      expect(find.byKey(const Key('tv_card_0')), findsOneWidget);

      // on tap testing
      await tester.tap(find.byKey(const Key('movie_card_0')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('this_is_watchlist')), findsNothing);
      expect(find.byKey(const Key('movie_card_0')), findsNothing);
      expect(find.byKey(const Key('tv_card_0')), findsNothing);
    },
  );

  testWidgets(
    "Tapping on card tv should go to tv show detail page",
    (WidgetTester tester) async {
      when(() => movieBloc.state)
          .thenReturn(MovieWatchlistHasData(testMovieList));
      when(() => tvBloc.state).thenReturn(TvWatchlistHasData(testTVList));

      await tester.pumpWidget(MaterialApp(
        routes: routes,
      ));

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);

      await tester.tap(find.byKey(const Key('fakeHome')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('this_is_watchlist')), findsOneWidget);
      expect(find.byKey(const Key('movie_card_0')), findsOneWidget);
      expect(find.byKey(const Key('tv_card_0')), findsOneWidget);

      // on tap testing
      await tester.tap(find.byKey(const Key('tv_card_0')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('this_is_watchlist')), findsNothing);
      expect(find.byKey(const Key('movie_card_0')), findsNothing);
      expect(find.byKey(const Key('tv_card_0')), findsNothing);
    },
  );
}
