import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pinput/pinput.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/pin_sheet/pin_sheet.dart';

import '../../../../../mock_specs.mocks.dart';
import '../../../../../test_app.dart';

void main() {
  final mockCacheHelper = MockSecureCacheHelper();
  // Test the `PinSheet` widget
  group('PinSheet', () {
    when(mockCacheHelper.readStringOrNull(any)).thenAnswer((_) async => '1212');
    when(mockCacheHelper.writeString(any, any)).thenAnswer((_) async {});

    // Test the `PinSheet` widget
    testWidgets('pin check test', (tester) async {
      // Build the `PinSheet` widget
      await tester.pumpWidget(
        TestApp(
          overrides: [cacheHelperProvider.overrideWithValue(mockCacheHelper)],
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    await PinSheet.show(context);
                  },
                  child: Text('Button'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.byType(PinSheet), findsOneWidget);
      await tester.pump();

      // Enter invalid the pin
      expect(find.byType(Pinput), findsNWidgets(1));
      await tester.pump();
      await tester.enterText(find.byType(Pinput), '1234');
      await tester.pump();
      expect(find.text('Invalid Pin'), findsOneWidget);
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      // Enter valid the pin
      await tester.enterText(find.byType(Pinput), '1212');
      await tester.pump();
      expect(find.byType(Pinput), findsNothing);

      // throwing error
      when(mockCacheHelper.readStringOrNull(any)).thenThrow(Exception());

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      await tester.enterText(find.byType(Pinput), '1212');
      await tester.pump();
      expect(find.byType(Pinput), findsNothing);
    });

    testWidgets('pin set test', (tester) async {
      // Build the `PinSheet` widget
      late BuildContext ctx;

      await tester.pumpWidget(
        TestApp(
          overrides: [cacheHelperProvider.overrideWithValue(mockCacheHelper)],
          home: Scaffold(
            body: Consumer(
              builder: (context, ref, child) {
                ctx = context;
                return ElevatedButton(
                  onPressed: () async {
                    await PinSheet.pinSet(
                      context,
                      ref,
                      redirectOnSuccess: false,
                    );
                  },
                  child: Text('Button'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.byType(PinSheet), findsOneWidget);
      await tester.pump();

      Navigator.of(ctx).pop();
      await tester.pump();
      expect(find.byType(Dialog), findsOneWidget);

      await tester.tap(find.text('Set Pin'));
      await tester.pump();
      expect(find.byType(PinSheet), findsOneWidget);
      await tester.enterText(find.byType(Pinput), '1212');
      await tester.pump();
      expect(find.byType(PinSheet), findsNothing);
    });
  });
}
