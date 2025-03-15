import 'package:equatable/equatable.dart';

/// Abstract class for all failures

/// Abstract class for all failures
abstract class Failure implements Exception, EquatableMixin {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;

  @override
  String toString() => message; // ✅ `stringify` is not needed
}

/// General failure
class GeneralFailure extends Failure {
  const GeneralFailure({required super.message});
}

/// Server failure (e.g., API errors)
class ServerFailure extends Failure {
  final int statusCode;
  const ServerFailure({required super.message, required this.statusCode});
}

/// Cache failure (e.g., local storage errors)
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

/// Network failure (e.g., no internet connection)
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}
