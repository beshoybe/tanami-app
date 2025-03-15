import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/domain/usecases/confirm_otp_usecase.dart'; // Import ConfirmOtpUsecase

import '../../../../mock_specs.mocks.dart';

void main() {
  late ConfirmOtpUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = ConfirmOtpUsecase(mockAuthRepository);
  });

  const email = "test@example.com";
  const otp = "123456";

  group('ConfirmOtpUsecase', () {
    test(
      'should return a string message when the OTP confirmation is successful',
      () async {
        // Arrange: Mock the repository call to return a successful response
        final successMessage = "OTP Confirmed";
        when(
          mockAuthRepository.confirmOtp(email, otp),
        ).thenAnswer((_) async => Right(successMessage));

        // Act: Call the usecase
        final result = await usecase(ConfirmOtpParams(otp: otp, email: email));

        // Assert: Verify the result is a success with the expected string message
        expect(result, Right(successMessage));
        verify(mockAuthRepository.confirmOtp(email, otp)).called(1);
      },
    );

    test('should return Failure when the OTP confirmation fails', () async {
      // Arrange: Mock the repository call to return a failure
      final failure = GeneralFailure(message: "OTP confirmation failed");
      when(
        mockAuthRepository.confirmOtp(email, otp),
      ).thenAnswer((_) async => Left(failure));

      // Act: Call the usecase
      final result = await usecase(ConfirmOtpParams(otp: otp, email: email));

      // Assert: Verify the result is a failure
      expect(result, Left(failure));
      verify(mockAuthRepository.confirmOtp(email, otp)).called(1);
    });
  });
}
