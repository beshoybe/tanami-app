import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/shared/widgets/app_error.dart';

import '../../test_app.dart';

void main() {
  group('AppError Widget', () {
    testWidgets('should display default error message', (tester) async {
      await tester.pumpWidget(TestApp(home: Scaffold(body: AppError())));

      expect(find.text('Unexpected error occured'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('should display custom error message', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: AppError(
              error: ServerFailure(message: 'Server error', statusCode: 500),
            ),
          ),
        ),
      );

      expect(find.text('Server error'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('should display retry button when onRetry is provided', (
      tester,
    ) async {
      var retried = false;
      await tester.pumpWidget(
        TestApp(
          home: Scaffold(
            body: AppError(
              onRetry: () {
                retried = true;
              },
            ),
          ),
        ),
      );

      final retryButton = find.text('Retry');
      expect(retryButton, findsOneWidget);

      await tester.tap(retryButton);
      await tester.pump();

      expect(retried, isTrue);
    });
  });
}
