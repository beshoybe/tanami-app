abstract class ConfirmOtpStates {}

class ConfirmOtpInitial extends ConfirmOtpStates {}

class ConfirmOtpLoading extends ConfirmOtpStates {}

class ConfirmOtpSuccess extends ConfirmOtpStates {
  final String token;

  ConfirmOtpSuccess({required this.token});
}

class ResendOtpSuccess extends ConfirmOtpStates {}

class ConfirmOtpValidationError extends ConfirmOtpStates {}

class ConfirmOtpError extends ConfirmOtpStates {
  final String message;

  ConfirmOtpError({required this.message});
}

class ConfirmOtpExpired extends ConfirmOtpError {
  ConfirmOtpExpired({required super.message});
}
