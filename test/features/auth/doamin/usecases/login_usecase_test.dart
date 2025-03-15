import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/data/models/auth_response_model.dart';
import 'package:tanami_capital/features/auth/domain/usecases/login_usecase.dart';

import '../../../../mock_specs.mocks.dart';

void main() {
  late LoginUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LoginUsecase(mockAuthRepository);
  });

  const email = "test@example.com";
  const password = "password123";
  final authResponse = AuthResponseModel(
    token: "jwt_token",
    refreshToken: "refresh_token",
    passwordLessToken: "password_less_token",
  );

  group('LoginUsecase', () {
    test(
      'should return AuthResponseEntity when the login is successful',
      () async {
        // Arrange: Mock the repository call to return a successful response
        when(
          mockAuthRepository.login(email, password),
        ).thenAnswer((_) async => Right(authResponse));

        // Act: Call the usecase
        final result = await usecase(
          LoginParams(email: email, password: password),
        );

        // Assert: Verify the result is a success with AuthResponseEntity
        expect(result, Right(authResponse));
        verify(mockAuthRepository.login(email, password)).called(1);
      },
    );

    test('should return Failure when the login fails', () async {
      // Arrange: Mock the repository call to return a failure
      final failure = GeneralFailure(message: "Login failed");
      when(
        mockAuthRepository.login(email, password),
      ).thenAnswer((_) async => Left(failure));

      // Act: Call the usecase
      final result = await usecase(
        LoginParams(email: email, password: password),
      );

      // Assert: Verify the result is a failure
      expect(result, Left(failure));
      verify(mockAuthRepository.login(email, password)).called(1);
    });
  });
}
