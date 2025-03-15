abstract class SignupStates {}

class SignupInitial extends SignupStates {}

class SignupLoading extends SignupStates {}

class SignupSuccess extends SignupStates {}

class SignupFailure extends SignupStates {
  final String message;

  SignupFailure({required this.message});
}

class SignupPasswordNotStrong extends SignupStates {
  SignupPasswordNotStrong();
}
