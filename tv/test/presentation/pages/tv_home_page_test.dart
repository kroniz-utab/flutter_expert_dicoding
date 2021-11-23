import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'app_helper.dart';
import 'helper/fake_test_helper.dart';

void main() {
  late FakeTvListBloc fakeTvListBloc;
  late FakeTvPopularBloc fakeTvPopularBloc;
  late FakeTvTopBloc fakeTvTopBloc;

  setUp(() {
    registerFallbackValue(FakeTvListEvent());
    registerFallbackValue(FakeTvListState());
    fakeTvListBloc = FakeTvListBloc();

    registerFallbackValue(FakeTvPopularEvent());
    registerFallbackValue(FakeTvPopularState());
    fakeTvPopularBloc = FakeTvPopularBloc();

    registerFallbackValue(FakeTvTopEvent());
    registerFallbackValue(FakeTvTopState());
    fakeTvTopBloc = FakeTvTopBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvListBloc>(
          create: (context) => fakeTvListBloc,
        ),
        BlocProvider<TvPopularBloc>(
          create: (context) => fakeTvPopularBloc,
        ),
        BlocProvider<TvTopRatedBloc>(
          create: (context) => fakeTvTopBloc,
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
        BlocProvider<TvListBloc>(
          create: (context) => fakeTvListBloc,
        ),
        BlocProvider<TvPopularBloc>(
          create: (context) => fakeTvPopularBloc,
        ),
        BlocProvider<TvTopRatedBloc>(
          create: (context) => fakeTvTopBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(const HomeTVPage()),
    tvDetailRoutes: (context) => const FakeDestination(),
    topRatedTVRoutes: (context) => const FakeDestination(),
    popularTVRoutes: (context) => const FakeDestination(),
    searchRoutes: (context) => const FakeDestination(),
  };

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeTvListBloc.state).thenReturn(TvListLoading());
    when(() => fakeTvPopularBloc.state).thenReturn(TvPopularLoading());
    when(() => fakeTvTopBloc.state).thenReturn(TvTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const HomeTVPage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display listview tvlist when hasdata',
      (tester) async {
    when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
    when(() => fakeTvPopularBloc.state)
        .thenReturn(TvPopularHasData(testTVList));
    when(() => fakeTvTopBloc.state).thenReturn(TvTopRatedHasData(testTVList));

    final listViewFinder = find.byType(ListView);
    final tvListFinder = find.byType(TVListLayout);

    await tester.pumpWidget(_createTestableWidget(const HomeTVPage()));

    expect(listViewFinder, findsNWidgets(3));
    expect(tvListFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeTvListBloc.state).thenReturn(TvListError('error'));
    when(() => fakeTvPopularBloc.state).thenReturn(TvPopularError('error'));
    when(() => fakeTvTopBloc.state).thenReturn(TvTopRatedError('error'));

    await tester.pumpWidget(_createTestableWidget(const HomeTVPage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });

  testWidgets('Page should display empty text when empty', (tester) async {
    when(() => fakeTvListBloc.state).thenReturn(TvListEmpty());
    when(() => fakeTvPopularBloc.state).thenReturn(TvPopularEmpty());
    when(() => fakeTvTopBloc.state).thenReturn(TvTopRatedEmpty());

    await tester.pumpWidget(_createTestableWidget(const HomeTVPage()));

    expect(find.byKey(const Key('empty_message')), findsNWidgets(3));
  });

  testWidgets('Tapping on see more (popular) should go to Popular page',
      (tester) async {
    when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
    when(() => fakeTvPopularBloc.state)
        .thenReturn(TvPopularHasData(testTVList));
    when(() => fakeTvTopBloc.state).thenReturn(TvTopRatedHasData(testTVList));

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
    expect(find.byKey(const Key('this_is_home_tv')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byKey(const Key('see_more_popular')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_top_rated')), findsNothing);
    expect(find.byKey(const Key('see_more_popular')), findsNothing);
    expect(find.byKey(const Key('this_is_home_tv')), findsNothing);
  });

  testWidgets('Tapping on see more (top rated) should go to top rated page',
      (tester) async {
    when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
    when(() => fakeTvPopularBloc.state)
        .thenReturn(TvPopularHasData(testTVList));
    when(() => fakeTvTopBloc.state).thenReturn(TvTopRatedHasData(testTVList));

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
    expect(find.byKey(const Key('this_is_home_tv')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byKey(const Key('see_more_top_rated')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_top_rated')), findsNothing);
    expect(find.byKey(const Key('see_more_popular')), findsNothing);
    expect(find.byKey(const Key('this_is_home_tv')), findsNothing);
  });

  testWidgets('Tapping on now playing card should go to tv detail page',
      (tester) async {
    when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
    when(() => fakeTvPopularBloc.state)
        .thenReturn(TvPopularHasData(testTVList));
    when(() => fakeTvTopBloc.state).thenReturn(TvTopRatedHasData(testTVList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('ota_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_tv')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byKey(const Key('ota_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('ota_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('this_is_home_tv')), findsNothing);
  });

  testWidgets('Tapping on popular card should go to tv detail page',
      (tester) async {
    when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
    when(() => fakeTvPopularBloc.state)
        .thenReturn(TvPopularHasData(testTVList));
    when(() => fakeTvTopBloc.state).thenReturn(TvTopRatedHasData(testTVList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('ota_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_tv')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byKey(const Key('popular_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('ota_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('this_is_home_tv')), findsNothing);
  });

  testWidgets('Tapping on top rated card should go to tv detail page',
      (tester) async {
    when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
    when(() => fakeTvPopularBloc.state)
        .thenReturn(TvPopularHasData(testTVList));
    when(() => fakeTvTopBloc.state).thenReturn(TvTopRatedHasData(testTVList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('ota_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_tv')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('top_rated_0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('top_rated_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('ota_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('this_is_home_tv')), findsNothing);
  });

  testWidgets('Tapping search icon should go to tv searchPage', (tester) async {
    when(() => fakeTvListBloc.state).thenReturn(TvListHasData(testTVList));
    when(() => fakeTvPopularBloc.state)
        .thenReturn(TvPopularHasData(testTVList));
    when(() => fakeTvTopBloc.state).thenReturn(TvTopRatedHasData(testTVList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byKey(const Key('this_is_home_tv')), findsOneWidget);

    // on tap testing
    await tester.tap(find.byIcon(Icons.search));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('this_is_home_tv')), findsNothing);
  });
}
