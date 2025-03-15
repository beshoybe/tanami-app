abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}

class LoginInvalidEmail extends LoginFailure {
  LoginInvalidEmail(super.message);
}

class LoginInvalidPassword extends LoginFailure {
  LoginInvalidPassword(super.message);
}
