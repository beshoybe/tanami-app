import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/config/extensions.dart';

import '../test_app.dart';

void main() {
  testWidgets(
    'toArabicNumber should return Arabic numerals when locale is not English',
    (WidgetTester tester) async {
      // Create a test widget with a BuildContext
      final testWidget = TestApp(
        locale: const Locale('ar'), // Simulate Arabic locale
        home: Builder(
          builder: (BuildContext context) {
            final arabicNumber = context.toArabicNumber('1234567890B');
            expect(arabicNumber, '١٢٣٤٥٦٧٨٩٠B');
            return Container();
          },
        ),
      );

      await tester.pumpWidget(testWidget);
    },
  );

  testWidgets(
    'toArabicNumber should return original number when locale is English',
    (WidgetTester tester) async {
      // Create a test widget with an English locale
      final testWidget = TestApp(
        locale: const Locale('en'), // Simulate English locale
        home: Builder(
          builder: (BuildContext context) {
            final englishNumber = context.toArabicNumber('1234567890');
            expect(englishNumber, '1234567890'); // No conversion
            return Container();
          },
        ),
      );

      await tester.pumpWidget(testWidget);
    },
  );
}
