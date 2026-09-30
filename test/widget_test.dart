import 'package:flutter/material.dart' show Icons, ScaffoldMessenger;
import 'package:flutter_test/flutter_test.dart';

import 'package:expense_tracker/main.dart';

void main() {
  testWidgets('app builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const ExpenseTrackerApp());

    expect(find.text('Good day, Jojan'), findsOneWidget);
    expect(find.text('Lunch'), findsOneWidget);
    expect(find.text('-₱150'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.receipt_long_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Lunch'), findsOneWidget);
    expect(find.text('-₱150'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pumpAndSettle();

    expect(find.byTooltip('QR scan'), findsOneWidget);
    expect(find.byTooltip('Quick scan'), findsOneWidget);

    await tester.tap(find.byTooltip('QR scan'));
    await tester.pump();
    expect(find.text('QR scan coming soon'), findsOneWidget);

    ScaffoldMessenger.of(
      tester.element(find.byTooltip('QR scan')),
    ).hideCurrentSnackBar();
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Quick scan'));
    await tester.pumpAndSettle();
    expect(find.text('Quick scan coming soon'), findsOneWidget);
  });
}
