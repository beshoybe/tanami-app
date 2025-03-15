import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/features/auth/data/models/auth_response_model.dart';
import 'package:tanami_capital/features/auth/presentation/pages/signup_page.dart';
import 'package:tanami_capital/features/auth/presentation/providers/auth_di.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/app_form_field.dart';

import '../../../../mock_specs.mocks.dart';
import '../../../../test_app.dart';

void main() {
  late MockSignupUsecase mockSignupUsecase;

  setUp(() {
    mockSignupUsecase = MockSignupUsecase();
  });

  testWidgets("should show loading state and navigate to PinSheet on success", (
    tester,
  ) async {
    // Mock signup use case
    when(mockSignupUsecase.call(any)).thenAnswer((_) async {
      log("Mocking signup usecase call");
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay
      return Right(
        AuthResponseModel(
          token: "jwt_token",
          refreshToken: "refresh_token",
          passwordLessToken: "password_less_token",
        ),
      );
    });

    // Build widget tree
    await tester.pumpWidget(
      TestApp(
        home: SignupPage(),
        overrides: [signupUsecaseProvider.overrideWithValue(mockSignupUsecase)],
      ),
    );

    // Verify initial UI
    expect(
      find.byType(AppFormField),
      findsNWidgets(5),
    ); // First Name, Last Name, Email, Password, Confirm Password
    expect(find.byType(AppButton), findsOneWidget);
    expect(find.text("Signup"), findsOneWidget);

    // Find form fields & button
    final firstNameField = find.byType(AppFormField).at(0);
    final lastNameField = find.byType(AppFormField).at(1);
    final emailField = find.byType(AppFormField).at(2);
    final passwordField = find.byType(AppFormField).at(3);
    final confirmPasswordField = find.byType(AppFormField).at(4);
    final signupButton = find.byType(AppButton);

    // Enter valid credentials
    await tester.enterText(firstNameField, 'John');
    await tester.enterText(lastNameField, 'Doe');
    await tester.enterText(emailField, 'test@gmail.com');
    await tester.enterText(passwordField, 'Test@123');
    await tester.enterText(confirmPasswordField, 'Test@123');
    await tester.tap(signupButton);
    await tester.pump(); // Process tap
    await tester.pump(); // Ensure state updates
    await tester.pump(Duration(milliseconds: 100)); // Give it time to change

    // Verify loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the login to complete
    await tester.pump(Duration(seconds: 2));
  });
}
