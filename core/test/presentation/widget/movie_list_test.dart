import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects_movie.dart';
import '../app_helper.dart';

void main() {
  late Movie data;

  final routes = <String, WidgetBuilder>{
    '/next': (context) => const FakeDestination(),
  };

  setUp(() {
    data = testMovie;
  });

  tearDown(() {
    PaintingBinding.instance?.imageCache?.clear();
    PaintingBinding.instance?.imageCache?.clearLiveImages();
  });

  testWidgets('should show card list properly when data not a watchlist',
      (tester) async {
    await tester.pumpWidget(
      testableMaterialApp(
        routes,
        FakeHome(
          body: MovieList(
            movies: data,
            onTap: () {},
          ),
        ),
      ),
    );
    expect(find.byKey(const Key('fakeHome')), findsOneWidget);
    final clipFinder = find.byType(ClipRRect);
    expect(clipFinder, findsOneWidget);
  });
}
