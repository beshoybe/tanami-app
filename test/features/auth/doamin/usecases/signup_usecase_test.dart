import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/data/models/auth_response_model.dart';
import 'package:tanami_capital/features/auth/domain/usecases/signup_usecase.dart'; // Import SignupUsecase

import '../../../../mock_specs.mocks.dart';

void main() {
  late SignupUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignupUsecase(mockAuthRepository);
  });

  const email = "test@example.com";
  const password = "password123";
  const name = "Test User";
  final authResponse = AuthResponseModel(
    token: "jwt_token",
    refreshToken: "refresh_token",
    passwordLessToken: "password_less_token",
  );

  group('SignupUsecase', () {
    test(
      'should return AuthResponseEntity when the signup is successful',
      () async {
        // Arrange: Mock the repository call to return a successful response
        when(
          mockAuthRepository.signup(email, password, name),
        ).thenAnswer((_) async => Right(authResponse));

        // Act: Call the usecase
        final result = await usecase(
          SignupParams(email: email, password: password, name: name),
        );

        // Assert: Verify the result is a success with AuthResponseEntity
        expect(result, Right(authResponse));
        verify(mockAuthRepository.signup(email, password, name)).called(1);
      },
    );

    test('should return Failure when the signup fails', () async {
      // Arrange: Mock the repository call to return a failure
      final failure = GeneralFailure(message: "Signup failed");
      when(
        mockAuthRepository.signup(email, password, name),
      ).thenAnswer((_) async => Left(failure));

      // Act: Call the usecase
      final result = await usecase(
        SignupParams(email: email, password: password, name: name),
      );

      // Assert: Verify the result is a failure
      expect(result, Left(failure));
      verify(mockAuthRepository.signup(email, password, name)).called(1);
    });
  });
}
