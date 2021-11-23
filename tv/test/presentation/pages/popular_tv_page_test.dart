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
  late FakeTvPopularBloc fakeBloc;

  setUp(() {
    registerFallbackValue(FakeTvPopularEvent());
    registerFallbackValue(FakeTvPopularState());
    fakeBloc = FakeTvPopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvPopularBloc>(
      create: (context) => fakeBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return BlocProvider<TvPopularBloc>(
      create: (context) => fakeBloc,
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(const PopularTVPage()),
    tvDetailRoutes: (context) => const FakeDestination(),
  };

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(TvPopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(TvPopularHasData(testTVList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(TvPopularError('error'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTVPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when empty',
      (WidgetTester tester) async {
    when(() => fakeBloc.state).thenReturn(TvPopularEmpty());

    final textFinder = find.byKey(const Key('empty_data'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTVPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Tapping on item should go to detail page', (tester) async {
    when(() => fakeBloc.state).thenReturn(TvPopularHasData(testTVList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    final movieCardFinder = find.byType(TVShowCard);
    expect(movieCardFinder, findsOneWidget);
    expect(find.byKey(const Key('card_0')), findsOneWidget);
    expect(find.byKey(const Key('this_is_popular_page')), findsOneWidget);
    expect(find.byKey(const Key('fakeHome')), findsNothing);

    await tester.tap(find.byKey(const Key('card_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('this_is_popular_page')), findsNothing);
  });
}
