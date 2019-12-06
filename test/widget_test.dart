// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smoothclock/main.dart';
import 'package:smoothclock/visu/BinaryClock.dart';
import 'package:smoothclock/visu/SmoothClock.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Smooth Clock'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();

    expect(find.text('Clock Styles'), findsOneWidget);

    await tester.tap(find.text("Binary Clock"));
    await tester.pump();

    expect(find.text('Binary Clock'), findsOneWidget);
  });
}
