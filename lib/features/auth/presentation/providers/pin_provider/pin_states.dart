abstract class PinStates {}

class PinInitial extends PinStates {}

class PinLoading extends PinStates {}

class PinSuccess extends PinStates {}

class PinInvalidPin extends PinStates {}

class PinError extends PinStates {
  final String message;

  PinError({required this.message});
}
