import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/data/models/auth_response_model.dart';
import 'package:tanami_capital/features/auth/presentation/pages/reset_password_page.dart';
import 'package:tanami_capital/features/auth/presentation/providers/auth_di.dart';
import 'package:tanami_capital/shared/widgets/app_dialog.dart';
import 'package:tanami_capital/shared/widgets/app_form_field.dart';

import '../../../../mock_specs.mocks.dart';
import '../../../../test_app.dart';

void main() {
  late MockResetPasswordUsecase mockResetPasswordUsecase;
  const String testToken = "reset_token_123";

  setUp(() {
    mockResetPasswordUsecase = MockResetPasswordUsecase();
  });

  group('Reset Password Cases Page', () {
    testWidgets("should show loading state and success message on reset", (
      tester,
    ) async {
      // Mock reset password use case
      when(mockResetPasswordUsecase.call(any)).thenAnswer((_) async {
        log("Mocking reset password use case call");
        await Future.delayed(Duration(seconds: 2)); // Simulate network delay
        return Right(
          AuthResponseModel(token: '', refreshToken: '', passwordLessToken: ''),
        ); // Reset password successful
      });

      // Build widget tree
      await tester.pumpWidget(
        TestApp(
          home: ResetPasswordPage(token: testToken),
          overrides: [
            resetPasswordUsecaseProvider.overrideWithValue(
              mockResetPasswordUsecase,
            ),
          ],
        ),
      );

      // Verify initial UI
      expect(
        find.byType(AppFormField),
        findsNWidgets(2),
      ); // Password & Confirm Password

      // Find form fields & button
      final passwordField = find.byType(AppFormField).first;
      final confirmPasswordField = find.byType(AppFormField).last;
      final resetPasswordButton = find.byKey(ValueKey('reset_password_btn'));

      // Scroll to make sure the button is visible

      // Enter valid new passwords
      await tester.enterText(passwordField, 'Test@123');
      await tester.enterText(confirmPasswordField, 'Test@123');

      // Tap the reset password button
      //scroll to make sure the button is visible
      await tester.ensureVisible(resetPasswordButton);
      await tester.tap(resetPasswordButton);
      await tester.pump(); // Wait for UI updates

      // Verify loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for the reset password to complete
      await tester.pump(Duration(seconds: 2));
    });
    testWidgets('Validation fail', (tester) async {
      // Build widget tree
      await tester.pumpWidget(
        TestApp(
          home: ResetPasswordPage(token: testToken),
          overrides: [
            resetPasswordUsecaseProvider.overrideWithValue(
              mockResetPasswordUsecase,
            ),
          ],
        ),
      );

      // Find form fields & button
      final passwordField = find.byType(AppFormField).first;
      final confirmPasswordField = find.byType(AppFormField).last;
      final resetPasswordButton = find.byKey(ValueKey('reset_password_btn'));
      //scroll to make sure the button is visible
      await tester.ensureVisible(resetPasswordButton);
      await tester.tap(resetPasswordButton);
      await tester.pump(); // Wait for UI updates
      expect(find.text('Password is required'), findsNWidgets(2));

      // Enter valid new passwords
      await tester.enterText(passwordField, 'Test@123');
      await tester.enterText(confirmPasswordField, 'Test@1234');

      // Tap the reset password button
      await tester.ensureVisible(resetPasswordButton);
      await tester.tap(resetPasswordButton);
      await tester.pump(); // Wait for UI updates
      expect(find.text('Passwords not match'), findsOneWidget);
    });
  });
  testWidgets("fail response test", (tester) async {
    // Mock reset password use case
    when(mockResetPasswordUsecase.call(any)).thenAnswer((_) async {
      log("Mocking reset password use case call");
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay
      return Left(
        ServerFailure(message: 'Server error', statusCode: 400),
      ); // Reset password successful
    });

    // Build widget tree
    await tester.pumpWidget(
      TestApp(
        home: ResetPasswordPage(token: testToken),
        overrides: [
          resetPasswordUsecaseProvider.overrideWithValue(
            mockResetPasswordUsecase,
          ),
        ],
      ),
    );

    // Find form fields & button
    final passwordField = find.byType(AppFormField).first;
    final confirmPasswordField = find.byType(AppFormField).last;
    final resetPasswordButton = find.byKey(ValueKey('reset_password_btn'));

    // Scroll to make sure the button is visible

    // Enter valid new passwords
    await tester.enterText(passwordField, 'Test@123');
    await tester.enterText(confirmPasswordField, 'Test@123');

    // Tap the reset password button
    //scroll to make sure the button is visible
    await tester.ensureVisible(resetPasswordButton);
    await tester.tap(resetPasswordButton);
    await tester.pump(); // Wait for UI updates

    // Verify loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the reset password to complete
    await tester.pump(Duration(seconds: 2));

    // Verify error message

    expect(find.text('Server error'), findsOneWidget);
  });
  testWidgets("expired token dialog shown", (tester) async {
    // Mock reset password use case
    when(mockResetPasswordUsecase.call(any)).thenAnswer((_) async {
      log("Mocking reset password use case call");
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay
      return Left(
        ServerFailure(message: 'Server error', statusCode: 410),
      ); // Reset password successful
    });

    // Build widget tree
    await tester.pumpWidget(
      TestApp(
        home: ResetPasswordPage(token: testToken),
        overrides: [
          resetPasswordUsecaseProvider.overrideWithValue(
            mockResetPasswordUsecase,
          ),
        ],
      ),
    );

    // Find form fields & button
    final passwordField = find.byType(AppFormField).first;
    final confirmPasswordField = find.byType(AppFormField).last;
    final resetPasswordButton = find.byKey(ValueKey('reset_password_btn'));

    // Scroll to make sure the button is visible

    // Enter valid new passwords
    await tester.enterText(passwordField, 'Test@123');
    await tester.enterText(confirmPasswordField, 'Test@123');

    // Tap the reset password button
    //scroll to make sure the button is visible
    await tester.ensureVisible(resetPasswordButton);
    await tester.tap(resetPasswordButton);
    await tester.pump(); // Wait for UI updates

    // Verify loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the reset password to complete
    await tester.pump(Duration(seconds: 2));

    // Verify dialog shown
    expect(find.byType(AppDialog), findsOneWidget);
  });
}
