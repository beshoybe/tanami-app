abstract class SplashStates {}

class SplashInitialState extends SplashStates {}

class SplashLoadingState extends SplashStates {}

class SplashLoadedState extends SplashStates {
  SplashLoadedState();
}

class SplashErrorState extends SplashStates {
  final String message;

  SplashErrorState(this.message);
}
