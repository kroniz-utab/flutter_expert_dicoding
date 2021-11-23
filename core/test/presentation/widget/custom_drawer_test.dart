import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../app_helper.dart';

void main() {
  final routes = <String, WidgetBuilder>{
    mainRoutes: (context) => const FakeDestination(),
    movieRoutes: (context) => const FakeDestination(),
    tvRoutes: (context) => const FakeDestination(),
    watchlistRoutes: (context) => const FakeDestination(),
    aboutRoutes: (context) => const FakeDestination(),
  };

  tearDown(() {
    PaintingBinding.instance?.imageCache?.clear();
    PaintingBinding.instance?.imageCache?.clearLiveImages();
  });

  Widget _createTestableWidget(Widget body, routes) {
    return MaterialApp(
      routes: routes,
      home: Material(
        child: body,
      ),
    );
  }

  testWidgets(
    "should show drawer when menu was clicked",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _createTestableWidget(
          const CustomDrawer(
            key: Key('custom_drawer'),
            location: 'test',
            content: FakeHome(
              body: ListTile(),
            ),
          ),
          routes,
        ),
      );

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byType(UserAccountsDrawerHeader), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.movie), findsOneWidget);
      expect(find.byIcon(Icons.live_tv), findsOneWidget);
      expect(find.byIcon(Icons.save_alt), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
      expect(find.byKey(const Key('custom_drawer')), findsOneWidget);
    },
  );

  testWidgets(
    "should go to home when clicked home menu",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _createTestableWidget(
          const CustomDrawer(
            location: 'test',
            content: FakeHome(
              body: ListTile(),
            ),
          ),
          routes,
        ),
      );

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.home), findsOneWidget);

      await tester.tap(find.byIcon(Icons.home));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.home), findsNothing);
      expect(find.byKey(const Key('fakeHome')), findsNothing);
      expect(find.byKey(const Key('fakeDestination')), findsOneWidget);
    },
  );

  testWidgets(
    "should to close menu when clicked home menu in main page",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _createTestableWidget(
          const CustomDrawer(
            location: mainRoutes,
            content: FakeHome(
              body: ListTile(),
            ),
          ),
          routes,
        ),
      );

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.home), findsOneWidget);

      await tester.tap(find.byIcon(Icons.home));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byKey(const Key('fakeDestination')), findsNothing);
    },
  );

  testWidgets(
    "should go to movie when clicked movie menu",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _createTestableWidget(
          const CustomDrawer(
            location: 'test',
            content: FakeHome(
              body: ListTile(),
            ),
          ),
          routes,
        ),
      );

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.movie), findsOneWidget);

      await tester.tap(find.byIcon(Icons.movie));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.movie), findsNothing);
      expect(find.byKey(const Key('fakeHome')), findsNothing);
      expect(find.byKey(const Key('fakeDestination')), findsOneWidget);
    },
  );

  testWidgets(
    "should close menu when clicked movie menu in movie home page",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _createTestableWidget(
          const CustomDrawer(
            location: movieRoutes,
            content: FakeHome(
              body: ListTile(),
            ),
          ),
          routes,
        ),
      );

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.movie), findsOneWidget);

      await tester.tap(find.byIcon(Icons.movie));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byKey(const Key('fakeDestination')), findsNothing);
    },
  );

  testWidgets(
    "should go to tv when clicked tv menu",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _createTestableWidget(
          const CustomDrawer(
            location: 'test',
            content: FakeHome(
              body: ListTile(),
            ),
          ),
          routes,
        ),
      );

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.live_tv), findsOneWidget);

      await tester.tap(find.byIcon(Icons.live_tv));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.live_tv), findsNothing);
      expect(find.byKey(const Key('fakeHome')), findsNothing);
      expect(find.byKey(const Key('fakeDestination')), findsOneWidget);
    },
  );

  testWidgets(
    "should close menu when clicked tv menu in tv home page",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _createTestableWidget(
          const CustomDrawer(
            location: tvRoutes,
            content: FakeHome(
              body: ListTile(),
            ),
          ),
          routes,
        ),
      );

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.live_tv), findsOneWidget);

      await tester.tap(find.byIcon(Icons.live_tv));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byKey(const Key('fakeDestination')), findsNothing);
    },
  );

  testWidgets(
    "should go to watchlist when clicked watchlist menu",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _createTestableWidget(
          const CustomDrawer(
            location: 'test',
            content: FakeHome(
              body: ListTile(),
            ),
          ),
          routes,
        ),
      );

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.save_alt), findsOneWidget);

      await tester.tap(find.byIcon(Icons.save_alt));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.save_alt), findsNothing);
      expect(find.byKey(const Key('fakeHome')), findsNothing);
      expect(find.byKey(const Key('fakeDestination')), findsOneWidget);
    },
  );

  testWidgets(
    "should close menu when clicked watchlist menu in watchlist page",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _createTestableWidget(
          const CustomDrawer(
            location: watchlistRoutes,
            content: FakeHome(
              body: ListTile(),
            ),
          ),
          routes,
        ),
      );

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.save_alt), findsOneWidget);

      await tester.tap(find.byIcon(Icons.save_alt));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byKey(const Key('fakeDestination')), findsNothing);
    },
  );

  testWidgets(
    "should go to about when clicked about menu",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _createTestableWidget(
          const CustomDrawer(
            location: 'test',
            content: FakeHome(
              body: ListTile(),
            ),
          ),
          routes,
        ),
      );

      expect(find.byKey(const Key('fakeHome')), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.info_outline), findsOneWidget);

      await tester.tap(find.byIcon(Icons.info_outline));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byIcon(Icons.info_outline), findsNothing);
      expect(find.byKey(const Key('fakeHome')), findsNothing);
      expect(find.byKey(const Key('fakeDestination')), findsOneWidget);
    },
  );
}
