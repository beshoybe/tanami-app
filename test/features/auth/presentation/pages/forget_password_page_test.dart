import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/presentation/pages/forget_password_page.dart';
import 'package:tanami_capital/features/auth/presentation/providers/auth_di.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/app_form_field.dart';

import '../../../../mock_specs.mocks.dart';
import '../../../../test_app.dart';

void main() {
  late MockForgetPasswordUsecase mockForgetPasswordUsecase;

  setUp(() {
    mockForgetPasswordUsecase = MockForgetPasswordUsecase();
  });
  testWidgets("should validate", (tester) async {
    // Mock login use case with a longer delay
    when(mockForgetPasswordUsecase.call(any)).thenAnswer((_) async {
      log("Mocking login usecase call");
      await Future.delayed(
        Duration(seconds: 2),
      ); // Ensure loading state appears
      return Right(null);
    });

    // Build widget tree
    await tester.pumpWidget(
      TestApp(
        navigatorKey: rootNavigatorKey,
        home: ForgetPasswordPage(navigateAfterFinish: true),
        overrides: [
          forgetPasswordUsecaseProvider.overrideWithValue(
            mockForgetPasswordUsecase,
          ),
        ],
      ),
    );

    // Verify initial UI
    expect(find.byType(AppFormField), findsNWidgets(1));
    expect(find.byType(AppButton), findsNWidgets(2));

    // Find form fields & button
    final emailField = find.byType(AppFormField).first;
    final forgetPassButton = find.byKey(Key('forgetPasswordButton'));
    await tester.tap(forgetPassButton);
    await tester.pump(); // Process tap
    expect(find.text('Email is required'), findsOneWidget);
    // Enter valid credentials
    await tester.enterText(emailField, 'beshoy');
    await tester.tap(forgetPassButton);
    await tester.pump(); // Process tap
    expect(find.text('Invalid email format'), findsOneWidget);
  });
  testWidgets("should show loading state and success", (tester) async {
    // Mock login use case with a longer delay
    when(mockForgetPasswordUsecase.call(any)).thenAnswer((_) async {
      log("Mocking login usecase call");
      await Future.delayed(
        Duration(seconds: 2),
      ); // Ensure loading state appears
      return Right(null);
    });

    // Build widget tree
    await tester.pumpWidget(
      TestApp(
        navigatorKey: rootNavigatorKey,
        home: ForgetPasswordPage(navigateAfterFinish: false),
        overrides: [
          forgetPasswordUsecaseProvider.overrideWithValue(
            mockForgetPasswordUsecase,
          ),
        ],
      ),
    );

    // Verify initial UI
    expect(find.byType(AppFormField), findsNWidgets(1));
    expect(find.byType(AppButton), findsNWidgets(2));

    // Find form fields & button
    final emailField = find.byType(AppFormField).first;
    final forgetPassButton = find.byKey(Key('forgetPasswordButton'));

    // Enter valid credentials
    await tester.enterText(emailField, 'test@gmail.com');
    await tester.tap(forgetPassButton);
    await tester.pump(); // Process tap
    await tester.pump(); // Ensure state updates
    await tester.pump(Duration(milliseconds: 100)); // Give it time to change

    // Verify loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the login to complete
    await tester.pump(Duration(seconds: 2));
  });
  testWidgets("should show error", (tester) async {
    // Mock login use case with a longer delay
    when(mockForgetPasswordUsecase.call(any)).thenAnswer((_) async {
      log("Mocking login usecase call");

      return Left(ServerFailure(message: 'Server error', statusCode: 400));
    });

    // Build widget tree
    await tester.pumpWidget(
      TestApp(
        navigatorKey: rootNavigatorKey,
        home: ForgetPasswordPage(navigateAfterFinish: false),
        overrides: [
          forgetPasswordUsecaseProvider.overrideWithValue(
            mockForgetPasswordUsecase,
          ),
        ],
      ),
    );

    // Find form fields & button
    final emailField = find.byType(AppFormField).first;
    final forgetPassButton = find.byKey(Key('forgetPasswordButton'));

    // Enter valid credentials
    await tester.enterText(emailField, 'test@gmail.com');
    await tester.ensureVisible(forgetPassButton);
    await tester.tap(forgetPassButton);
    await tester.pump(); // Process tap

    expect(find.text('Server error'), findsOneWidget);
  });
}
