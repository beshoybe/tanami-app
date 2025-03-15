import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/data/models/auth_response_model.dart';
import 'package:tanami_capital/features/auth/domain/usecases/password_less_login_usecase.dart'; // Import PasswordLessLoginUsecase

import '../../../../mock_specs.mocks.dart';

void main() {
  late PasswordLessLoginUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = PasswordLessLoginUsecase(mockAuthRepository);
  });

  const token = "password_less_token";
  final authResponse = AuthResponseModel(
    token: "jwt_token",
    refreshToken: "refresh_token",
    passwordLessToken: token,
  );

  group('PasswordLessLoginUsecase', () {
    test(
      'should return AuthResponseEntity when the passwordless login is successful',
      () async {
        // Arrange: Mock the repository call to return a successful response
        when(
          mockAuthRepository.passwordLessLogin(token),
        ).thenAnswer((_) async => Right(authResponse));

        // Act: Call the usecase
        final result = await usecase(token);

        // Assert: Verify the result is a success with AuthResponseEntity
        expect(result, Right(authResponse));
        verify(mockAuthRepository.passwordLessLogin(token)).called(1);
      },
    );

    test('should return Failure when the passwordless login fails', () async {
      // Arrange: Mock the repository call to return a failure
      final failure = GeneralFailure(message: "Passwordless login failed");
      when(
        mockAuthRepository.passwordLessLogin(token),
      ).thenAnswer((_) async => Left(failure));

      // Act: Call the usecase
      final result = await usecase(token);

      // Assert: Verify the result is a failure
      expect(result, Left(failure));
      verify(mockAuthRepository.passwordLessLogin(token)).called(1);
    });
  });
}
