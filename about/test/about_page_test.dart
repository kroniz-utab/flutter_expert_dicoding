import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeHomePage extends StatelessWidget {
  const FakeHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        key: const Key('ini palsu'),
        onTap: () {
          Navigator.pushNamed(context, '/next');
        },
        title: const Text('Fake Page'),
        leading: const Icon(Icons.check),
      ),
    );
  }
}

void main() {
  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) => const AboutPage(),
  };

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('should render pages and go back when back tapped',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));
    expect(find.byKey(const Key('ini palsu')), findsOneWidget);

    await tester.tap(find.byKey(const Key('ini palsu')));

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(seconds: 1));

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
    expect(find.byKey(const Key('ini palsu')), findsNothing);

    await tester.tap(find.byType(IconButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(seconds: 1));
    expect(imageFinder, findsNothing);
  });
}
