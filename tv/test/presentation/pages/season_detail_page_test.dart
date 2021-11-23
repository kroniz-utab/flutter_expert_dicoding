// ignore_for_file: prefer_const_constructors

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
  late FakeSeasonDetailBloc fakeBloc;

  setUpAll(() {
    registerFallbackValue(FakeSeasonDetailEvent());
    registerFallbackValue(FakeSeasonDetailState());
    fakeBloc = FakeSeasonDetailBloc();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<TvSeasonDetailBloc>(
      create: (context) => fakeBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return BlocProvider<TvSeasonDetailBloc>(
      create: (context) => fakeBloc,
      child: body,
    );
  }

  final widgetTester1 = SeasonDetailPage(
    tvId: 1,
    season: 1,
    tvPosterPath: testTvDetail.posterPath,
    seasonList: testTvDetail.seasons,
    tvName: testTvDetail.name,
  );

  final widgetTester2 = SeasonDetailPage(
    tvId: 1,
    season: 1,
    tvPosterPath: testTvDetail.posterPath,
    seasonList: [
      testTvDetail.seasons[0],
      testTvDetail.seasons[0],
    ],
    tvName: testTvDetail.name,
  );

  final routes1 = <String, WidgetBuilder>{
    '/': (context) => FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(widgetTester1),
    seasonDetailRoutes: (context) => FakeDestination(),
  };

  final routes2 = <String, WidgetBuilder>{
    '/': (context) => FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(widgetTester2),
    seasonDetailRoutes: (context) => FakeDestination(),
  };

  testWidgets(
    "should show circular progress when season detail is loading",
    (WidgetTester tester) async {
      when(() => fakeBloc.state).thenReturn(TvSeasonDetailLoading());

      await tester.pumpWidget(_createTestableWidget(widgetTester1));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    "should show error message when season detail is error",
    (WidgetTester tester) async {
      when(() => fakeBloc.state).thenReturn(TvSeasonDetailError('message'));

      await tester.pumpWidget(_createTestableWidget(widgetTester1));

      expect(find.byKey(Key('season_error')), findsOneWidget);
    },
  );

  testWidgets(
    "should show empty sized box when season detail is empty",
    (WidgetTester tester) async {
      when(() => fakeBloc.state).thenReturn(TvSeasonDetailEmpty());

      await tester.pumpWidget(_createTestableWidget(widgetTester1));

      expect(find.byKey(Key('season_empty')), findsOneWidget);
    },
  );

  testWidgets(
    "should find arrow back and can pop season detail page",
    (WidgetTester tester) async {
      when(() => fakeBloc.state)
          .thenReturn(TvSeasonDetailHasData(testTvSeason));

      await tester.pumpWidget(MaterialApp(
        routes: routes1,
      ));

      expect(find.byKey(Key('fakeHome')), findsOneWidget);

      await tester.tap(find.byKey(Key('fakeHome')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(Key('fakeHome')), findsNothing);
      expect(find.byKey(Key('this_is_season_detail')), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(Key('fakeHome')), findsOneWidget);
      expect(find.byKey(Key('this_is_season_detail')), findsNothing);
      expect(find.byIcon(Icons.arrow_back), findsNothing);
    },
  );

  testWidgets(
    "should not found season list when seasonlist lenght is 1",
    (WidgetTester tester) async {
      when(() => fakeBloc.state)
          .thenReturn(TvSeasonDetailHasData(testTvSeason));

      await tester.pumpWidget(MaterialApp(
        routes: routes1,
      ));

      expect(find.byKey(Key('fakeHome')), findsOneWidget);

      await tester.tap(find.byKey(Key('fakeHome')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(Key('fakeHome')), findsNothing);
      expect(find.byKey(Key('this_is_season_detail')), findsOneWidget);
      expect(find.byKey(Key('season_0')), findsNothing);
      expect(find.byKey(Key('other_season')), findsNothing);
      expect(find.byType(SeasonsList), findsNothing);
    },
  );

  testWidgets(
    "should found season list when seasonlist lenght is more than",
    (WidgetTester tester) async {
      when(() => fakeBloc.state)
          .thenReturn(TvSeasonDetailHasData(testTvSeason));

      await tester.pumpWidget(MaterialApp(
        routes: routes2,
      ));

      expect(find.byKey(Key('fakeHome')), findsOneWidget);

      await tester.tap(find.byKey(Key('fakeHome')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(Key('fakeHome')), findsNothing);
      expect(find.byKey(Key('this_is_season_detail')), findsOneWidget);
      expect(find.byKey(Key('other_season')), findsOneWidget);
      expect(find.byKey(Key('season_0')), findsOneWidget);
      expect(find.byType(SeasonsList), findsWidgets);

      await tester.dragUntilVisible(
        find.byKey(Key('season_0')),
        find.byType(SingleChildScrollView),
        Offset(0, 50),
      );
      await tester.tap(find.byKey(Key('season_0')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(Key('this_is_season_detail')), findsNothing);
      expect(find.byKey(Key('season_0')), findsNothing);
      expect(find.byKey(Key('other_season')), findsNothing);
      expect(find.byType(SeasonsList), findsNothing);
    },
  );
}
