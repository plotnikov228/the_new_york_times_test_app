// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:top_stories_test/data/datasources/connection_info.dart';
import 'package:top_stories_test/data/datasources/local_datasources/story_local_datasources.dart';
import 'package:top_stories_test/data/datasources/remote_datasources/story_remote_datasources.dart';
import 'package:top_stories_test/data/repository/story_repository.dart';
import 'package:top_stories_test/domain/usecases/get_local_stories.dart';
import 'package:top_stories_test/domain/usecases/get_remote_stories.dart';

import 'package:top_stories_test/main.dart';
import 'package:top_stories_test/notifications.dart';

void main() {


  int sum(int a, int b) {
    return a + b;
  }

  test('test1', () async {
    final res = sum(1, 1);
    expect(res, 2);
  });


  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
