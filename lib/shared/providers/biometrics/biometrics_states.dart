abstract class BiometricsStates {}

class BiometricsInitialState extends BiometricsStates {}

class BiometricsLoadingState extends BiometricsStates {}

class BiometricsAuthenticatedState extends BiometricsStates {}

class BiometricsUnauthenticatedState extends BiometricsStates {}

class BiometricsErrorState extends BiometricsStates {
  final String message;

  BiometricsErrorState(this.message);
}
