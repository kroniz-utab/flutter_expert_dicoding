import 'package:core/core.dart';
import 'package:flutter/material.dart';

class FakePage extends StatefulWidget {
  const FakePage({Key? key}) : super(key: key);

  @override
  State<FakePage> createState() => _FakePageState();
}

class _FakePageState extends State<FakePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      key: const Key('ini_fake'),
      child: CustomDrawer(
        location: 'fake-location',
        content: Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.menu),
            title: const Text('fake title'),
          ),
        ),
      ),
    );
  }
}

void main() {
  // setUpAll(() {
  //   TestWidgetsFlutterBinding.ensureInitialized();
  // });

  // testWidgets('should show custom drawer properly', (tester) async {
  //   await tester.pumpWidget(const FakePage());
  //   await tester.pump();
  //   await tester.pump(const Duration(milliseconds: 10));
  //   await tester.pump(const Duration(seconds: 1));
  //   expect(find.byKey(const Key('ini fake')), findsNothing);
  // });
}
