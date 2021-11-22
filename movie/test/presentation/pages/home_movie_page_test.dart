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
  late FakeMovieListBloc fakeMovieListBloc;
  late FakePopularMovieBloc fakePopularMovieBloc;
  late FakeTopRatedMovieBloc fakeTopRatedMovieBloc;

  setUp(() {
    registerFallbackValue(FakeMovieListEvent());
    registerFallbackValue(FakeMovieListState());
    fakeMovieListBloc = FakeMovieListBloc();

    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
    fakePopularMovieBloc = FakePopularMovieBloc();

    registerFallbackValue(FakeTopRatedMovieEvent());
    registerFallbackValue(FakeTopRatedMovieState());
    fakeTopRatedMovieBloc = FakeTopRatedMovieBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieListBloc>(
          create: (context) => fakeMovieListBloc,
        ),
        BlocProvider<MoviePopularBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<MovieTopRatedBloc>(
          create: (context) => fakeTopRatedMovieBloc,
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
        BlocProvider<MovieListBloc>(
          create: (context) => fakeMovieListBloc,
        ),
        BlocProvider<MoviePopularBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<MovieTopRatedBloc>(
          create: (context) => fakeTopRatedMovieBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(const HomeMoviePage()),
    movieDetailRoutes: (context) => const FakeDestination(),
    topRatedMovieRoutes: (context) => const FakeDestination(),
    popularMovieRoutes: (context) => const FakeDestination(),
    searchRoutes: (context) => const FakeDestination(),
  };

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(MovieListLoading());
    when(() => fakePopularMovieBloc.state).thenReturn(MoviePopularLoading());
    when(() => fakeTopRatedMovieBloc.state).thenReturn(MovieTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display listview movielist when hasdata',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    final listViewFinder = find.byType(ListView);
    final movieListFinder = find.byType(MovieList);

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsNWidgets(3));
    expect(movieListFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(MovieListError('error'));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularError('error'));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedError('error'));

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });

  testWidgets('Page should display empty text when empty', (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(MovieListEmpty());
    when(() => fakePopularMovieBloc.state).thenReturn(MoviePopularEmpty());
    when(() => fakeTopRatedMovieBloc.state).thenReturn(MovieTopRatedEmpty());

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(find.byKey(const Key('empty_message')), findsNWidgets(3));
  });

  testWidgets('Tapping on see more (popular) should go to Popular page',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_top_rated')), findsOneWidget);
    expect(find.byKey(const Key('see_more_popular')), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_movie')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byKey(const Key('see_more_popular')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_top_rated')), findsNothing);
    expect(find.byKey(const Key('see_more_popular')), findsNothing);
    expect(find.byKey(const Key('this_is_home_movie')), findsNothing);
  });

  testWidgets('Tapping on see more (top rated) should go to top rated page',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_top_rated')), findsOneWidget);
    expect(find.byKey(const Key('see_more_popular')), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_movie')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byKey(const Key('see_more_top_rated')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_top_rated')), findsNothing);
    expect(find.byKey(const Key('see_more_popular')), findsNothing);
    expect(find.byKey(const Key('this_is_home_movie')), findsNothing);
  });

  testWidgets('Tapping on now playing card should go to movie detail page',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_play_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_movie')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byKey(const Key('now_play_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_play_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('this_is_home_movie')), findsNothing);
  });

  testWidgets('Tapping on popular card should go to movie detail page',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_play_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_movie')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byKey(const Key('popular_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_play_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('this_is_home_movie')), findsNothing);
  });

  testWidgets('Tapping search icon should go to movie searchPage',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_movie')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byIcon(Icons.search));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('this_is_home_movie')), findsNothing);
  });
}
