abstract class ForgetPasswordStates {}

class ForgetPasswordInitial extends ForgetPasswordStates {}

class ForgetPasswordLoading extends ForgetPasswordStates {}

class ForgetPasswordSuccess extends ForgetPasswordStates {}

class ForgetPasswordError extends ForgetPasswordStates {
  final String error;

  ForgetPasswordError(this.error);
}
