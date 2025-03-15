import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/data/models/auth_response_model.dart';
import 'package:tanami_capital/features/auth/data/repositories/auth_repository_impl.dart';

import '../../../mock_specs.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockAuthDatasource();
    repository = AuthRepositoryImpl(mockDatasource);
  });

  const email = "test@example.com";
  const password = "password123";
  const name = "Test User";
  const token = "reset_token";
  const otp = "123456";

  final authResponse = AuthResponseModel(
    token: "jwt_token",
    refreshToken: "refresh_token",
    passwordLessToken: "password_less_token",
  );

  group("AuthRepositoryImpl", () {
    test("should return AuthResponseEntity on successful login", () async {
      when(
        mockDatasource.login(email, password),
      ).thenAnswer((_) async => authResponse);

      final result = await repository.login(email, password);

      expect(result, Right(authResponse));
      verify(mockDatasource.login(email, password)).called(1);
    });

    test("should return Failure on login failure", () async {
      final failure = GeneralFailure(message: "Login failed");
      when(mockDatasource.login(email, password)).thenThrow(failure);

      final result = await repository.login(email, password);

      expect(result, Left(failure));
      verify(mockDatasource.login(email, password)).called(1);
    });
    test("should return Failure on login failure for exception", () async {
      final failure = Exception("Login failed");

      // Mock the datasource to throw an exception
      when(mockDatasource.login(email, password)).thenThrow(failure);

      // Call the repository method
      final result = await repository.login(email, password);

      // Use fold to handle Left (failure) and assert the error type
      result.fold(
        (failure) {
          // Ensure the failure is a GeneralFailure with the correct message
          expect(failure, isA<GeneralFailure>());
          expect(failure.message, "Exception: Login failed");
        },
        (_) {
          // The right side should not be reached, so fail the test if it does
          fail('Expected failure, but got success');
        },
      );

      // Verify that the datasource method was called
      verify(mockDatasource.login(email, password)).called(1);
    });

    test("should return AuthResponseEntity on successful signup", () async {
      when(
        mockDatasource.signup(email, password, name),
      ).thenAnswer((_) async => authResponse);

      final result = await repository.signup(email, password, name);

      expect(result, Right(authResponse));
      verify(mockDatasource.signup(email, password, name)).called(1);
    });

    test("should return Failure on signup failure", () async {
      final failure = GeneralFailure(message: "Signup failed");
      when(mockDatasource.signup(email, password, name)).thenThrow(failure);

      final result = await repository.signup(email, password, name);

      expect(result, Left(failure));
      verify(mockDatasource.signup(email, password, name)).called(1);
    });
    test("should return Failure on signup failure for exception", () async {
      final failure = Exception("Signup failed");

      // Mock the datasource to throw an exception
      when(mockDatasource.signup(email, password, name)).thenThrow(failure);

      // Call the repository method
      final result = await repository.signup(email, password, name);

      // Use fold to handle Left (failure) and assert the error type
      result.fold(
        (failure) {
          // Ensure the failure is a GeneralFailure with the correct message
          expect(failure, isA<GeneralFailure>());
          expect(failure.message, "Exception: Signup failed");
        },
        (_) {
          // The right side should not be reached, so fail the test if it does
          fail('Expected failure, but got success');
        },
      );

      // Verify that the datasource method was called
      verify(mockDatasource.signup(email, password, name)).called(1);
    });

    test("should return void on successful forgetPassword", () async {
      when(mockDatasource.forgetPassword(email)).thenAnswer((_) async {});

      final result = await repository.forgetPassword(email);

      expect(result, const Right(null));
      verify(mockDatasource.forgetPassword(email)).called(1);
    });

    test("should return Failure on forgetPassword failure", () async {
      final failure = GeneralFailure(message: "Failed to send reset email");
      when(mockDatasource.forgetPassword(email)).thenThrow(failure);

      final result = await repository.forgetPassword(email);

      expect(result, Left(failure));
      verify(mockDatasource.forgetPassword(email)).called(1);
    });
    test(
      "should return Failure on forgetPassword failure for exception",
      () async {
        final failure = Exception("Forget Password failed");

        // Mock the datasource to throw an exception
        when(mockDatasource.forgetPassword(email)).thenThrow(failure);

        // Call the repository method
        final result = await repository.forgetPassword(email);

        // Use fold to handle Left (failure) and assert the error type
        result.fold(
          (failure) {
            // Ensure the failure is a GeneralFailure with the correct message
            expect(failure, isA<GeneralFailure>());
            expect(failure.message, "Exception: Forget Password failed");
          },
          (_) {
            // The right side should not be reached, so fail the test if it does
            fail('Expected failure, but got success');
          },
        );

        // Verify that the datasource method was called
        verify(mockDatasource.forgetPassword(email)).called(1);
      },
    );

    test("should return token on successful confirmOtp", () async {
      when(
        mockDatasource.confirmOtp(email, otp),
      ).thenAnswer((_) async => "verified_token");

      final result = await repository.confirmOtp(email, otp);

      expect(result, const Right("verified_token"));
      verify(mockDatasource.confirmOtp(email, otp)).called(1);
    });

    test("should return Failure on confirmOtp failure", () async {
      final failure = GeneralFailure(message: "OTP verification failed");
      when(mockDatasource.confirmOtp(email, otp)).thenThrow(failure);

      final result = await repository.confirmOtp(email, otp);

      expect(result, Left(failure));
      verify(mockDatasource.confirmOtp(email, otp)).called(1);
    });
    test("should return Failure on confirmOtp failure for exception", () async {
      final failure = Exception("OTP verification failed");

      // Mock the datasource to throw an exception
      when(mockDatasource.confirmOtp(email, otp)).thenThrow(failure);

      // Call the repository method
      final result = await repository.confirmOtp(email, otp);

      // Use fold to handle Left (failure) and assert the error type
      result.fold(
        (failure) {
          // Ensure the failure is a GeneralFailure with the correct message
          expect(failure, isA<GeneralFailure>());
          expect(failure.message, "Exception: OTP verification failed");
        },
        (_) {
          // The right side should not be reached, so fail the test if it does
          fail('Expected failure, but got success');
        },
      );

      // Verify that the datasource method was called
      verify(mockDatasource.confirmOtp(email, otp)).called(1);
    });

    test(
      "should return AuthResponseEntity on successful resetPassword",
      () async {
        when(
          mockDatasource.resetPassword(token, password),
        ).thenAnswer((_) async => authResponse);

        final result = await repository.resetPassword(token, password);

        expect(result, Right(authResponse));
        verify(mockDatasource.resetPassword(token, password)).called(1);
      },
    );

    test("should return Failure on resetPassword failure", () async {
      final failure = GeneralFailure(message: "Reset failed");
      when(mockDatasource.resetPassword(token, password)).thenThrow(failure);

      final result = await repository.resetPassword(token, password);

      expect(result, Left(failure));
      verify(mockDatasource.resetPassword(token, password)).called(1);
    });
    test(
      "should return Failure on resetPassword failure for exception",
      () async {
        final failure = Exception("Reset failed");

        // Mock the datasource to throw an exception
        when(mockDatasource.resetPassword(token, password)).thenThrow(failure);

        // Call the repository method
        final result = await repository.resetPassword(token, password);

        // Use fold to handle Left (failure) and assert the error type
        result.fold(
          (failure) {
            // Ensure the failure is a GeneralFailure with the correct message
            expect(failure, isA<GeneralFailure>());
            expect(failure.message, "Exception: Reset failed");
          },
          (_) {
            // The right side should not be reached, so fail the test if it does
            fail('Expected failure, but got success');
          },
        );

        // Verify that the datasource method was called
        verify(mockDatasource.resetPassword(token, password)).called(1);
      },
    );

    // New test for passwordLessLogin
    test(
      "should return AuthResponseEntity on successful passwordLessLogin",
      () async {
        when(
          mockDatasource.passwordLessLogin(token),
        ).thenAnswer((_) async => authResponse);

        final result = await repository.passwordLessLogin(token);

        expect(result, Right(authResponse));
        verify(mockDatasource.passwordLessLogin(token)).called(1);
      },
    );

    test("should return Failure on passwordLessLogin failure", () async {
      final failure = GeneralFailure(message: "Password less login failed");
      when(mockDatasource.passwordLessLogin(token)).thenThrow(failure);

      final result = await repository.passwordLessLogin(token);

      expect(result, Left(failure));
      verify(mockDatasource.passwordLessLogin(token)).called(1);
    });
    test(
      "should return Failure on passwordLessLogin failure exception",
      () async {
        final failure = Exception("failed");

        // Mock the datasource to throw an exception
        when(mockDatasource.passwordLessLogin(token)).thenThrow(failure);

        // Call the repository method
        final result = await repository.passwordLessLogin(token);

        // Use fold to handle Left (failure) and assert the error type
        result.fold(
          (failure) {
            // Ensure the failure is a GeneralFailure with the correct message
            expect(failure, isA<GeneralFailure>());
            expect(failure.message, "Exception: failed");
          },
          (_) {
            // The right side should not be reached, so fail the test if it does
            fail('Expected failure, but got success');
          },
        );

        // Verify that the datasource method was called
        verify(mockDatasource.passwordLessLogin(token)).called(1);
      },
    );
  });
}
