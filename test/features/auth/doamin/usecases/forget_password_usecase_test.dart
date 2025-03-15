import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/domain/usecases/forget_password_usecase.dart'; // Import ForgetPasswordUsecase

import '../../../../mock_specs.mocks.dart';

void main() {
  late ForgetPasswordUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = ForgetPasswordUsecase(mockAuthRepository);
  });

  const email = "test@example.com";

  group('ForgetPasswordUsecase', () {
    test('should return void when the forget password is successful', () async {
      // Arrange: Mock the repository call to return a successful response
      when(
        mockAuthRepository.forgetPassword(email),
      ).thenAnswer((_) async => Right(null));

      // Act: Call the usecase
      final result = await usecase(email);

      // Assert: Verify the result is successful with void
      expect(result, Right(null));
      verify(mockAuthRepository.forgetPassword(email)).called(1);
    });

    test('should return Failure when the forget password fails', () async {
      // Arrange: Mock the repository call to return a failure
      final failure = GeneralFailure(message: "Forget password failed");
      when(
        mockAuthRepository.forgetPassword(email),
      ).thenAnswer((_) async => Left(failure));

      // Act: Call the usecase
      final result = await usecase(email);

      // Assert: Verify the result is a failure
      expect(result, Left(failure));
      verify(mockAuthRepository.forgetPassword(email)).called(1);
    });
  });
}
