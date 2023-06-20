import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webrtc/counter.dart';

void main() {
  group("Counter", () {
    testWidgets('widgets exists', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Counter())));

      expect(find.text("0"), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('should increment', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Counter())));

      expect(find.text("0"), findsOneWidget);

      await tester.tap(find.widgetWithIcon(IconButton, Icons.add));

      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should decrement', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: Counter(
        counter: 2,
      ))));

      expect(find.text("2"), findsOneWidget);

      await tester.tap(find.widgetWithIcon(IconButton, Icons.remove));

      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should disable minus button because counter value is 0',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Counter())));

      await tester.tap(find.widgetWithIcon(IconButton, Icons.remove));

      await tester.pump();

      expect(find.text('0'), findsOneWidget);
    });
  });
}
