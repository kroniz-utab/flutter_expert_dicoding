import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:ditonton/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import '../dummy_data/dummy_objects_movie.dart';
import '../dummy_data/dummy_objects_tv.dart';
import 'app_helper.dart';
import 'helper/pages_test_helper.dart';

void main() {
  late FakeMovieListBloc fakeMovieListBloc;
  late FakePopularMovieBloc fakePopularMovieBloc;
  late FakeTvListBloc fakeTvListBloc;
  late FakePopularTvBloc fakePopularTvBloc;
  late Widget widgetToTest;

  setUp(() {
    registerFallbackValue(FakeMovieListEvent());
    registerFallbackValue(FakeMovieListState());
    fakeMovieListBloc = FakeMovieListBloc();

    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
    fakePopularMovieBloc = FakePopularMovieBloc();

    registerFallbackValue(FakeTvListEvent());
    registerFallbackValue(FakeTvListState());
    fakeTvListBloc = FakeTvListBloc();

    registerFallbackValue(FakePopularTvEvent());
    registerFallbackValue(FakePopularTvState());
    fakePopularTvBloc = FakePopularTvBloc();

    widgetToTest = MainPage();
  });

  Widget _createHomeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieListBloc>(
          create: (context) => fakeMovieListBloc,
        ),
        BlocProvider<MoviePopularBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TvListBloc>(create: (context) => fakeTvListBloc),
        BlocProvider<TvPopularBloc>(
          create: (context) => fakePopularTvBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createDestinationTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieListBloc>(
          create: (context) => fakeMovieListBloc,
        ),
        BlocProvider<MoviePopularBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TvListBloc>(create: (context) => fakeTvListBloc),
        BlocProvider<TvPopularBloc>(
          create: (context) => fakePopularTvBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => FakeHome(),
    '/next': (context) => _createDestinationTestableWidget(widgetToTest),
    movieDetailRoutes: (context) => FakeDestination(),
    movieRoutes: (context) => FakeDestination(),
    tvDetailRoutes: (context) => FakeDestination(),
    tvRoutes: (context) => FakeDestination(),
    watchlistRoutes: (context) => FakeDestination(),
  };

  testWidgets('should display progress bar when movie list loading',
      (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(MovieListLoading());
    when(() => fakePopularMovieBloc.state).thenReturn(MoviePopularLoading());
    when(() => fakeTvListBloc.state).thenReturn(TvListLoading());
    when(() => fakePopularTvBloc.state).thenReturn(TvPopularLoading());

    await tester.pumpWidget(_createHomeTestableWidget(widgetToTest));
    final progresssbarFinder = find.byType(CircularProgressIndicator);
    expect(progresssbarFinder, findsNWidgets(4));
  });

  testWidgets('should display carousel and card listview when data loaded',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
    when(() => fakePopularTvBloc.state)
        .thenReturn(TvPopularHasData(testTVList));

    await tester.pumpWidget(_createHomeTestableWidget(widgetToTest));

    final listviewFinder = find.byType(ListView);
    final carouselFinder = find.byType(CarouselSlider);
    final hotTvKeyFinder = find.byKey(Key('hot_tv'));
    final hotMovieKeyFinder = find.byKey(Key('hot_movies'));

    expect(listviewFinder, findsNWidgets(2));
    expect(carouselFinder, findsNWidgets(2));
    expect(hotTvKeyFinder, findsOneWidget);
    expect(hotMovieKeyFinder, findsOneWidget);
  });

  testWidgets('should display empty text when data is empty', (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(MovieListEmpty());
    when(() => fakePopularMovieBloc.state).thenReturn(MoviePopularEmpty());
    when(() => fakeTvListBloc.state).thenReturn(TvListEmpty());
    when(() => fakePopularTvBloc.state).thenReturn(TvPopularEmpty());

    await tester.pumpWidget(_createHomeTestableWidget(widgetToTest));

    final keyFinder = find.byKey(Key('data_kosong'));

    expect(keyFinder, findsNWidgets(4));
  });

  testWidgets('should display error text when data is empty', (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(MovieListError('error'));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularError('error'));
    when(() => fakeTvListBloc.state).thenReturn(TvListError('error'));
    when(() => fakePopularTvBloc.state).thenReturn(TvPopularError('error'));

    await tester.pumpWidget(_createHomeTestableWidget(widgetToTest));

    final keyFinder = find.byKey(Key('data_error'));

    expect(keyFinder, findsNWidgets(4));
  });

  group('on Tap Testing', () {
    testWidgets(
      'should goes to movie home page when hot_movie clicked',
      (tester) async {
        when(() => fakeMovieListBloc.state)
            .thenReturn(MovieListHasData(testMovieList));
        when(() => fakePopularMovieBloc.state)
            .thenReturn(MoviePopularHasData(testMovieList));
        when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
        when(() => fakePopularTvBloc.state)
            .thenReturn(TvPopularHasData(testTVList));

        await tester.pumpWidget(MaterialApp(
          routes: routes,
        ));

        expect(find.byKey(const Key('fakeHome')), findsOneWidget);

        await tester.tap(find.byKey(const Key('fakeHome')));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        final hotTvKeyFinder = find.byKey(Key('hot_tv'));
        final hotMovieKeyFinder = find.byKey(Key('hot_movies'));

        expect(hotTvKeyFinder, findsOneWidget);
        expect(hotMovieKeyFinder, findsOneWidget);

        // on Tap testing
        await tester.tap(find.byKey(Key('hot_movies')));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(hotTvKeyFinder, findsNothing);
        expect(hotMovieKeyFinder, findsNothing);
      },
    );

    testWidgets(
      'should goes to tv home page when hot_tv clicked',
      (tester) async {
        when(() => fakeMovieListBloc.state)
            .thenReturn(MovieListHasData(testMovieList));
        when(() => fakePopularMovieBloc.state)
            .thenReturn(MoviePopularHasData(testMovieList));
        when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
        when(() => fakePopularTvBloc.state)
            .thenReturn(TvPopularHasData(testTVList));

        await tester.pumpWidget(MaterialApp(
          routes: routes,
        ));

        expect(find.byKey(const Key('fakeHome')), findsOneWidget);

        await tester.tap(find.byKey(const Key('fakeHome')));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        final hotTvKeyFinder = find.byKey(Key('hot_tv'));
        final hotMovieKeyFinder = find.byKey(Key('hot_movies'));

        expect(hotTvKeyFinder, findsOneWidget);
        expect(hotMovieKeyFinder, findsOneWidget);

        // on Tap testing
        await tester.dragUntilVisible(
          hotTvKeyFinder,
          find.byType(SingleChildScrollView),
          Offset(0, 300),
        );
        await tester.tap(hotTvKeyFinder);

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(hotTvKeyFinder, findsNothing);
        expect(hotMovieKeyFinder, findsNothing);
      },
    );

    testWidgets(
      'should goes to movie detail page when movie carousel clicked',
      (tester) async {
        when(() => fakeMovieListBloc.state)
            .thenReturn(MovieListHasData(testMovieList));
        when(() => fakePopularMovieBloc.state)
            .thenReturn(MoviePopularHasData(testMovieList));
        when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
        when(() => fakePopularTvBloc.state)
            .thenReturn(TvPopularHasData(testTVList));

        await tester.pumpWidget(MaterialApp(
          routes: routes,
        ));

        expect(find.byKey(const Key('fakeHome')), findsOneWidget);

        await tester.tap(find.byKey(const Key('fakeHome')));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(find.byKey(Key('mCard_0')), findsOneWidget);
        expect(find.byKey(Key('main_page')), findsOneWidget);

        // on Tap testing
        await tester.tap(find.byKey(Key('mCard_0')));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(find.byKey(Key('mCard_0')), findsNothing);
        expect(find.byKey(Key('main_page')), findsNothing);
      },
    );

    testWidgets(
      'should goes to tv detail page when tv carousel clicked',
      (tester) async {
        when(() => fakeMovieListBloc.state)
            .thenReturn(MovieListHasData(testMovieList));
        when(() => fakePopularMovieBloc.state)
            .thenReturn(MoviePopularHasData(testMovieList));
        when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
        when(() => fakePopularTvBloc.state)
            .thenReturn(TvPopularHasData(testTVList));

        await tester.pumpWidget(MaterialApp(
          routes: routes,
        ));

        expect(find.byKey(const Key('fakeHome')), findsOneWidget);

        await tester.tap(find.byKey(const Key('fakeHome')));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(find.byKey(Key('tCard_0')), findsOneWidget);
        expect(find.byKey(Key('main_page')), findsOneWidget);

        // on Tap testing
        await tester.dragUntilVisible(
          find.byKey(Key('tCard_0')),
          find.byType(SingleChildScrollView),
          Offset(0, 400),
        );
        await tester.tap(find.byKey(Key('tCard_0')));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(find.byKey(Key('tCard_0')), findsNothing);
        expect(find.byKey(Key('main_page')), findsNothing);
      },
    );

    testWidgets(
      'should goes to watchlist page when watchlist icon clicked',
      (tester) async {
        when(() => fakeMovieListBloc.state)
            .thenReturn(MovieListHasData(testMovieList));
        when(() => fakePopularMovieBloc.state)
            .thenReturn(MoviePopularHasData(testMovieList));
        when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
        when(() => fakePopularTvBloc.state)
            .thenReturn(TvPopularHasData(testTVList));

        await tester.pumpWidget(MaterialApp(
          routes: routes,
        ));

        expect(find.byKey(const Key('fakeHome')), findsOneWidget);

        await tester.tap(find.byKey(const Key('fakeHome')));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(find.byKey(Key('go_to_watchlist')), findsOneWidget);
        expect(find.byKey(Key('main_page')), findsOneWidget);

        // on Tap testing
        await tester.tap(find.byKey(Key('go_to_watchlist')));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(find.byKey(Key('go_to_watchlist')), findsNothing);
        expect(find.byKey(Key('main_page')), findsNothing);
      },
    );
  });
}
