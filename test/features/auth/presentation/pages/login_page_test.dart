import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/features/auth/data/models/auth_response_model.dart';
import 'package:tanami_capital/features/auth/presentation/pages/login_page.dart';
import 'package:tanami_capital/features/auth/presentation/providers/auth_di.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/app_form_field.dart';

import '../../../../mock_specs.mocks.dart';
import '../../../../test_app.dart';

void main() {
  late MockLoginUsecase mockLoginUsecase;

  setUp(() {
    mockLoginUsecase = MockLoginUsecase();
  });

  testWidgets("should show loading state and success", (tester) async {
    // Mock login use case with a longer delay
    when(mockLoginUsecase.call(any)).thenAnswer((_) async {
      log("Mocking login usecase call");
      await Future.delayed(
        Duration(seconds: 2),
      ); // Ensure loading state appears
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
        home: LoginPage(),
        overrides: [loginUsecaseProvider.overrideWithValue(mockLoginUsecase)],
      ),
    );

    // Verify initial UI
    expect(find.byType(AppFormField), findsNWidgets(2));
    expect(find.byType(AppButton), findsOneWidget);
    expect(find.text("Login"), findsOneWidget);

    // Find form fields & button
    final emailField = find.byType(AppFormField).first;
    final passwordField = find.byType(AppFormField).last;
    final loginButton = find.byType(AppButton);

    // Enter valid credentials
    await tester.enterText(emailField, 'test@gmail.com');
    await tester.enterText(passwordField, 'password');
    await tester.tap(loginButton);
    await tester.pump(); // Process tap
    await tester.pump(); // Ensure state updates
    await tester.pump(Duration(milliseconds: 100)); // Give it time to change

    // Verify loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the login to complete
    await tester.pump(Duration(seconds: 2));
  });
}
