import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/data/models/auth_response_model.dart';
import 'package:tanami_capital/features/auth/domain/usecases/reset_password_usecase.dart'; // Import ResetPasswordUsecase

import '../../../../mock_specs.mocks.dart';

void main() {
  late ResetPasswordUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = ResetPasswordUsecase(mockAuthRepository);
  });

  const token = "reset_token";
  const newPassword = "new_password123";
  final authResponse = AuthResponseModel(
    token: "jwt_token",
    refreshToken: "refresh_token",
    passwordLessToken: "password_less_token",
  );

  group('ResetPasswordUsecase', () {
    test(
      'should return AuthResponseEntity when the password reset is successful',
      () async {
        // Arrange: Mock the repository call to return a successful response
        when(
          mockAuthRepository.resetPassword(token, newPassword),
        ).thenAnswer((_) async => Right(authResponse));

        // Act: Call the usecase
        final result = await usecase(
          ResetPasswordParams(token: token, password: newPassword),
        );

        // Assert: Verify the result is a success with AuthResponseEntity
        expect(result, Right(authResponse));
        verify(mockAuthRepository.resetPassword(token, newPassword)).called(1);
      },
    );

    test('should return Failure when the password reset fails', () async {
      // Arrange: Mock the repository call to return a failure
      final failure = GeneralFailure(message: "Reset password failed");
      when(
        mockAuthRepository.resetPassword(token, newPassword),
      ).thenAnswer((_) async => Left(failure));

      // Act: Call the usecase
      final result = await usecase(
        ResetPasswordParams(token: token, password: newPassword),
      );

      // Assert: Verify the result is a failure
      expect(result, Left(failure));
      verify(mockAuthRepository.resetPassword(token, newPassword)).called(1);
    });
  });
}
