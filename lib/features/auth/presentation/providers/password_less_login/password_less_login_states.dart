abstract class PasswordLessLoginStates {}

class PasswordLessLoginInitial extends PasswordLessLoginStates {}

class PasswordLessLoginLoading extends PasswordLessLoginStates {
  final bool isPin;

  PasswordLessLoginLoading(this.isPin);
}

class PasswordLessLoginSuccess extends PasswordLessLoginStates {}

class PasswordLessLoginError extends PasswordLessLoginStates {
  final String error;

  PasswordLessLoginError(this.error);
}
