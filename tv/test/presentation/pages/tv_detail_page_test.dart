// ignore_for_file: prefer_const_constructors

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'app_helper.dart';
import 'helper/fake_test_helper.dart';

void main() {
  late FakeTvDetailBloc fakeTVBloc;
  late FakeTvWatchlistBloc fakeWatchlistBloc;
  late FakeTvRecomBloc fakeRecomBloc;
  late FakeSimilarBloc fakeSimilar;

  setUpAll(() {
    registerFallbackValue(FakeTvDetailEvent());
    registerFallbackValue(FakeTvDetailState());
    fakeTVBloc = FakeTvDetailBloc();

    registerFallbackValue(FakeTvWatchlistEvent());
    registerFallbackValue(FakeTvWatchlistState());
    fakeWatchlistBloc = FakeTvWatchlistBloc();

    registerFallbackValue(FakeTvRecomEvent());
    registerFallbackValue(FakeTvRecomState());
    fakeRecomBloc = FakeTvRecomBloc();

    registerFallbackValue(FakeSimilarState());
    registerFallbackValue(FakeSimilarEvent());
    fakeSimilar = FakeSimilarBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(
          create: (context) => fakeTVBloc,
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<TvRecommendationBloc>(
          create: (context) => fakeRecomBloc,
        ),
        BlocProvider<TvSimilarBloc>(
          create: (context) => fakeSimilar,
        )
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _makeAnotherTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(
          create: (context) => fakeTVBloc,
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<TvRecommendationBloc>(
          create: (context) => fakeRecomBloc,
        ),
        BlocProvider<TvSimilarBloc>(
          create: (context) => fakeSimilar,
        )
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) => _makeAnotherTestableWidget(TVDetailPage(id: 1)),
    tvDetailRoutes: (context) => FakeDestination(),
    seasonDetailRoutes: (context) => FakeDestination(),
  };

  testWidgets('should show circular progress when TV detail is loading',
      (tester) async {
    when(() => fakeTVBloc.state).thenReturn(TvDetailLoading());
    when(() => fakeRecomBloc.state).thenReturn(TvRecommendationLoading());
    when(() => fakeSimilar.state).thenReturn(TvSimilarLoading());
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(false));

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTvDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error message progress when TV detail is error',
      (tester) async {
    when(() => fakeTVBloc.state).thenReturn(TvDetailError('error'));
    when(() => fakeRecomBloc.state).thenReturn(TvRecommendationLoading());
    when(() => fakeSimilar.state).thenReturn(TvSimilarLoading());
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(false));

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTvDetail.id)));

    expect(find.byKey(Key('error_message')), findsOneWidget);
  });

  testWidgets('should show empty message progress when TV detail is empty',
      (tester) async {
    when(() => fakeTVBloc.state).thenReturn(TvDetailEmpty());
    when(() => fakeRecomBloc.state).thenReturn(TvRecommendationLoading());
    when(() => fakeSimilar.state).thenReturn(TvSimilarLoading());
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(false));

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTvDetail.id)));

    expect(find.byKey(Key('empty_message')), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when TV not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTVBloc.state).thenReturn(TvDetailHasData(testTvDetail));
    when(() => fakeRecomBloc.state)
        .thenReturn(TvRecommendationHasData(testTVList));
    when(() => fakeSimilar.state).thenReturn(TvSimilarHasData(testTVList));
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTvDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when TV is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeTVBloc.state).thenReturn(TvDetailHasData(testTvDetail));
    when(() => fakeRecomBloc.state)
        .thenReturn(TvRecommendationHasData(testTVList));
    when(() => fakeSimilar.state).thenReturn(TvSimilarHasData(testTVList));
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTvDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTVBloc.state).thenReturn(TvDetailHasData(testTvDetail));
    when(() => fakeRecomBloc.state)
        .thenReturn(TvRecommendationHasData(testTVList));
    when(() => fakeSimilar.state).thenReturn(TvSimilarHasData(testTVList));
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTvDetail.id)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsNothing);
  });

  testWidgets(
      'Watchlist button should display Snackbar when remove from watchlist',
      (WidgetTester tester) async {
    when(() => fakeTVBloc.state).thenReturn(TvDetailHasData(testTvDetail));
    when(() => fakeRecomBloc.state)
        .thenReturn(TvRecommendationHasData(testTVList));
    when(() => fakeSimilar.state).thenReturn(TvSimilarHasData(testTVList));
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(true));

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTvDetail.id)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsNothing);
  });

  testWidgets(
      'should show circular progress when TV recom and similar is loading',
      (tester) async {
    when(() => fakeTVBloc.state).thenReturn(TvDetailHasData(testTvDetail));
    when(() => fakeRecomBloc.state).thenReturn(TvRecommendationLoading());
    when(() => fakeSimilar.state).thenReturn(TvSimilarLoading());
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(false));

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTvDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsNWidgets(4));
  });

  testWidgets(
      'should show ListView ClipRReact when TV recom and similar is has data',
      (tester) async {
    when(() => fakeTVBloc.state).thenReturn(TvDetailHasData(testTvDetail));
    when(() => fakeRecomBloc.state)
        .thenReturn(TvRecommendationHasData(testTVList));
    when(() => fakeSimilar.state).thenReturn(TvSimilarHasData(testTVList));
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(false));

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTvDetail.id)));

    expect(find.byType(ListView), findsNWidgets(3));
    expect(find.byType(ClipRRect), findsNWidgets(3));
  });

  testWidgets('should show error text when TV recom is error', (tester) async {
    when(() => fakeTVBloc.state).thenReturn(TvDetailHasData(testTvDetail));
    when(() => fakeRecomBloc.state).thenReturn(TvRecommendationError('error'));
    when(() => fakeSimilar.state).thenReturn(TvSimilarError('error'));
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(false));

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTvDetail.id)));

    expect(find.byKey(Key('recom_error')), findsOneWidget);
    expect(find.byKey(Key('similar_error')), findsOneWidget);
  });

  testWidgets('should show sizedbox when TV recom is empty', (tester) async {
    when(() => fakeTVBloc.state).thenReturn(TvDetailHasData(testTvDetail));
    when(() => fakeRecomBloc.state).thenReturn(TvRecommendationEmpty());
    when(() => fakeSimilar.state).thenReturn(TvSimilarEmpty());
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(false));

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTvDetail.id)));

    expect(find.byKey(Key('recom_empty')), findsOneWidget);
    expect(find.byKey(Key('similar_empty')), findsOneWidget);
  });

  testWidgets(
    "should back to previous page when arrow back icon was clicked",
    (WidgetTester tester) async {
      when(() => fakeTVBloc.state).thenReturn(TvDetailHasData(testTvDetail));
      when(() => fakeRecomBloc.state)
          .thenReturn(TvRecommendationHasData(testTVList));
      when(() => fakeSimilar.state).thenReturn(TvSimilarHasData(testTVList));
      when(() => fakeWatchlistBloc.state)
          .thenReturn(TvIsAddedToWatchlist(false));

      await tester.pumpWidget(MaterialApp(
        routes: routes,
      ));

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);

      await tester.tap(find.byKey(const Key('fakeHome')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byKey(const Key('fakeHome')), findsNothing);

      await tester.tap(find.byIcon(Icons.arrow_back));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsNothing);
    },
  );

  testWidgets(
    "should go to another TV detail page when recom card was clicked",
    (WidgetTester tester) async {
      when(() => fakeTVBloc.state).thenReturn(TvDetailHasData(testTvDetail));
      when(() => fakeRecomBloc.state)
          .thenReturn(TvRecommendationHasData(testTVList));
      when(() => fakeSimilar.state).thenReturn(TvSimilarHasData(testTVList));
      when(() => fakeWatchlistBloc.state)
          .thenReturn(TvIsAddedToWatchlist(false));

      await tester.pumpWidget(MaterialApp(
        routes: routes,
      ));

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);

      await tester.tap(find.byKey(const Key('fakeHome')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(Key('recom_0')), findsOneWidget);

      await tester.dragUntilVisible(
        find.byKey(Key('recom_0')),
        find.byType(SingleChildScrollView),
        Offset(0, 100),
      );
      await tester.tap(find.byKey(Key('recom_0')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(Key('recom_0')), findsNothing);
    },
  );

  testWidgets(
    "should go to another TV detail page when similar card was clicked",
    (WidgetTester tester) async {
      when(() => fakeTVBloc.state).thenReturn(TvDetailHasData(testTvDetail));
      when(() => fakeRecomBloc.state)
          .thenReturn(TvRecommendationHasData(testTVList));
      when(() => fakeSimilar.state).thenReturn(TvSimilarHasData(testTVList));
      when(() => fakeWatchlistBloc.state)
          .thenReturn(TvIsAddedToWatchlist(false));

      await tester.pumpWidget(MaterialApp(
        routes: routes,
      ));

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);

      await tester.tap(find.byKey(const Key('fakeHome')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(Key('similar_0')), findsOneWidget);

      await tester.dragUntilVisible(
        find.byKey(Key('similar_0')),
        find.byType(SingleChildScrollView),
        Offset(0, 100),
      );
      await tester.tap(find.byKey(Key('similar_0')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(Key('similar_0')), findsNothing);
    },
  );

  testWidgets(
    "should go to another TV season page when season card was clicked",
    (WidgetTester tester) async {
      when(() => fakeTVBloc.state).thenReturn(TvDetailHasData(testTvDetail));
      when(() => fakeRecomBloc.state)
          .thenReturn(TvRecommendationHasData(testTVList));
      when(() => fakeSimilar.state).thenReturn(TvSimilarHasData(testTVList));
      when(() => fakeWatchlistBloc.state)
          .thenReturn(TvIsAddedToWatchlist(false));

      await tester.pumpWidget(MaterialApp(
        routes: routes,
      ));

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);

      await tester.tap(find.byKey(const Key('fakeHome')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(Key('season_0')), findsOneWidget);

      await tester.dragUntilVisible(
        find.byKey(Key('season_0')),
        find.byType(SingleChildScrollView),
        Offset(0, 100),
      );
      await tester.tap(find.byKey(Key('season_0')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(Key('season_0')), findsNothing);
    },
  );
}
