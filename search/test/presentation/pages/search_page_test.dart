import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';

import '../../dummy_data/dummy_objects_movie.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import 'app_helper.dart';
import 'helper/fake_search_helper.dart';

void main() {
  late FakeMovieSearchBloc movieBloc;
  late FakeTVSearchBloc tvBloc;

  setUp(() {
    registerFallbackValue(FakeMovieSearchEvent());
    registerFallbackValue(FakeMovieSearchState());
    movieBloc = FakeMovieSearchBloc();

    registerFallbackValue(FakeTVSearchEvent());
    registerFallbackValue(FakeTVSearchState());
    tvBloc = FakeTVSearchBloc();
  });

  tearDown(() {
    movieBloc.close();
    tvBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchMoviesBloc>(
          create: (context) => movieBloc,
        ),
        BlocProvider<SearchTvBloc>(
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
        BlocProvider<SearchMoviesBloc>(
          create: (context) => movieBloc,
        ),
        BlocProvider<SearchTvBloc>(
          create: (context) => tvBloc,
        ),
      ],
      child: body,
    );
  }

  group(
    'testing for movies search, ',
    () {
      final routes = <String, WidgetBuilder>{
        '/': (context) => const FakeHome(),
        '/next': (context) => _createAnotherTestableWidget(const SearchPage(
              isMovieSearch: true,
            )),
        movieDetailRoutes: (context) => const FakeDestination(),
        tvDetailRoutes: (context) => const FakeDestination(),
      };

      testWidgets(
        "Page should display Loading indicator when data is loading",
        (WidgetTester tester) async {
          when(() => movieBloc.state).thenReturn(SearchMoviesLoading());

          final progressbarFinder = find.byType(CircularProgressIndicator);

          await tester.pumpWidget(
              _createTestableWidget(const SearchPage(isMovieSearch: true)));

          expect(progressbarFinder, findsOneWidget);
        },
      );
      testWidgets(
        "Page should display ListView when data is gotten successful",
        (WidgetTester tester) async {
          when(() => movieBloc.state)
              .thenReturn(SearchMoviesHasData(testMovieList));

          final listViewFinder = find.byType(ListView);

          await tester.pumpWidget(
              _createTestableWidget(const SearchPage(isMovieSearch: true)));

          expect(listViewFinder, findsOneWidget);
        },
      );

      testWidgets(
        "Page should display error message when data is gotten error",
        (WidgetTester tester) async {
          when(() => movieBloc.state).thenReturn(SearchMoviesError('error'));

          final errorKeyFinder = find.byKey(const Key('error_message'));

          await tester.pumpWidget(
              _createTestableWidget(const SearchPage(isMovieSearch: true)));

          for (var i = 0; i < 5; i++) {
            await tester.pump(const Duration(seconds: 1));
          }

          expect(errorKeyFinder, findsOneWidget);
        },
      );

      testWidgets(
        "Page should display empty message when data is gotten empty",
        (WidgetTester tester) async {
          when(() => movieBloc.state).thenReturn(SearchMoviesEmpty());

          final emptyKeyFinder = find.byKey(const Key('empty_message'));

          await tester.pumpWidget(
              _createTestableWidget(const SearchPage(isMovieSearch: true)));

          for (var i = 0; i < 5; i++) {
            await tester.pump(const Duration(seconds: 1));
          }

          expect(emptyKeyFinder, findsOneWidget);
        },
      );

      testWidgets(
        "Page should display ListView when data is gotten successful and tap must go to movie detail page",
        (WidgetTester tester) async {
          when(() => movieBloc.state)
              .thenReturn(SearchMoviesHasData(testMovieList));

          await tester.pumpWidget(
            MaterialApp(
              routes: routes,
            ),
          );

          expect(find.byKey(const Key('fakeHome')), findsOneWidget);

          await tester.tap(find.byKey(const Key('fakeHome')));

          for (var i = 0; i < 5; i++) {
            await tester.pump(const Duration(seconds: 1));
          }

          expect(find.byKey(const Key('ini_search_page')), findsOneWidget);
          expect(find.byKey(const Key('movie_card_0')), findsOneWidget);
          expect(find.byKey(const Key('movie_text_field')), findsOneWidget);
          expect(find.byKey(const Key('fakeDestination')), findsNothing);

          // on tap testing
          await tester.tap(find.byKey(const Key('movie_card_0')));

          for (var i = 0; i < 5; i++) {
            await tester.pump(const Duration(seconds: 1));
          }

          expect(find.byKey(const Key('ini_search_page')), findsNothing);
          expect(find.byKey(const Key('movie_card_0')), findsNothing);
          expect(find.byKey(const Key('movie_text_field')), findsNothing);
          expect(find.byKey(const Key('fakeDestination')), findsOneWidget);
        },
      );
    },
  );

  group(
    'testing for tv search, ',
    () {
      final routes = <String, WidgetBuilder>{
        '/': (context) => const FakeHome(),
        '/next': (context) => _createAnotherTestableWidget(const SearchPage(
              isMovieSearch: false,
            )),
        movieDetailRoutes: (context) => const FakeDestination(),
        tvDetailRoutes: (context) => const FakeDestination(),
      };

      testWidgets(
        "Page should display Loading indicator when data is loading",
        (WidgetTester tester) async {
          when(() => tvBloc.state).thenReturn(SearchTvLoading());

          final progressbarFinder = find.byType(CircularProgressIndicator);

          await tester.pumpWidget(
              _createTestableWidget(const SearchPage(isMovieSearch: false)));

          expect(progressbarFinder, findsOneWidget);
        },
      );
      testWidgets(
        "Page should display ListView and TvShowCard when data is gotten successful",
        (WidgetTester tester) async {
          when(() => tvBloc.state).thenReturn(SearchTvHasData(testTVList));

          final listViewFinder = find.byType(ListView);
          final tvShowCardFinder = find.byType(TVShowCard);

          await tester.pumpWidget(
              _createTestableWidget(const SearchPage(isMovieSearch: false)));

          expect(listViewFinder, findsOneWidget);
          expect(tvShowCardFinder, findsOneWidget);
        },
      );

      testWidgets(
        "Page should display error message when data is gotten error",
        (WidgetTester tester) async {
          when(() => tvBloc.state).thenReturn(SearchTvError('error'));

          final errorKeyFinder = find.byKey(const Key('error_message'));

          await tester.pumpWidget(
              _createTestableWidget(const SearchPage(isMovieSearch: false)));

          for (var i = 0; i < 5; i++) {
            await tester.pump(const Duration(seconds: 1));
          }

          expect(errorKeyFinder, findsOneWidget);
        },
      );

      testWidgets(
        "Page should display empty message when data is gotten empty",
        (WidgetTester tester) async {
          when(() => tvBloc.state).thenReturn(SearchTvEmpty());

          final emptyKeyFinder = find.byKey(const Key('empty_message'));

          await tester.pumpWidget(
              _createTestableWidget(const SearchPage(isMovieSearch: false)));

          for (var i = 0; i < 5; i++) {
            await tester.pump(const Duration(seconds: 1));
          }

          expect(emptyKeyFinder, findsOneWidget);
        },
      );

      testWidgets(
        "Page should display ListView when data is gotten successful and tap must go to tv detail page",
        (WidgetTester tester) async {
          when(() => tvBloc.state).thenReturn(SearchTvHasData(testTVList));

          await tester.pumpWidget(
            MaterialApp(
              routes: routes,
            ),
          );

          expect(find.byKey(const Key('fakeHome')), findsOneWidget);

          await tester.tap(find.byKey(const Key('fakeHome')));

          for (var i = 0; i < 5; i++) {
            await tester.pump(const Duration(seconds: 1));
          }

          expect(find.byKey(const Key('ini_search_page')), findsOneWidget);
          expect(find.byKey(const Key('tv_card_0')), findsOneWidget);
          expect(find.byKey(const Key('tv_text_field')), findsOneWidget);
          expect(find.byKey(const Key('fakeDestination')), findsNothing);

          // on tap testing
          await tester.tap(find.byKey(const Key('tv_card_0')));

          for (var i = 0; i < 5; i++) {
            await tester.pump(const Duration(seconds: 1));
          }

          expect(find.byKey(const Key('ini_search_page')), findsNothing);
          expect(find.byKey(const Key('tv_card_0')), findsNothing);
          expect(find.byKey(const Key('tv_text_field')), findsNothing);
          expect(find.byKey(const Key('fakeDestination')), findsOneWidget);
        },
      );
    },
  );
}
