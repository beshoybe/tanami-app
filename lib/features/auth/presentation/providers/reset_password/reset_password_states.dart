abstract class ResetPasswordStates {}

class ResetPasswordInitial extends ResetPasswordStates {}

class ResetPasswordLoading extends ResetPasswordStates {}

class ResetPasswordSuccess extends ResetPasswordStates {}

class ResetPasswordValidationError extends ResetPasswordStates {}

class ResetPasswordExpired extends ResetPasswordStates {
  final String message;

  ResetPasswordExpired({required this.message});
}

class ResetPasswordError extends ResetPasswordStates {
  final String message;

  ResetPasswordError({required this.message});
}
