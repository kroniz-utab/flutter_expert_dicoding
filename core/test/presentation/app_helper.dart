import 'package:core/core.dart';
import 'package:flutter/material.dart';

class FakeHome extends StatelessWidget {
  final Widget body;
  const FakeHome({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('fakeHome'),
      body: body,
      appBar: AppBar(
        title: const Text('fakeHome'),
        leading: const Icon(Icons.menu),
      ),
    );
  }
}

class FakeDestination extends StatelessWidget {
  const FakeDestination({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('fakeDestination'),
      body: const Center(
        child: Text('ini destinasi'),
      ),
      appBar: AppBar(
        title: const Text('fakeDestination'),
        leading: const Icon(Icons.menu),
      ),
    );
  }
}

MaterialApp testableMaterialApp(routes, page) {
  return MaterialApp(
    theme: ThemeData.dark().copyWith(
      colorScheme: kColorScheme,
      primaryColor: kRichBlack,
      scaffoldBackgroundColor: kRichBlack,
      textTheme: kTextTheme,
    ),
    home: page,
  );
}
