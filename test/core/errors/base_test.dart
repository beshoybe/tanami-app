import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/core/errors/base.dart';

void main() {
  group('Failure Tests', () {
    const generalFailure = GeneralFailure(message: 'Something went wrong');
    const serverFailure = ServerFailure(
      message: 'Server Error',
      statusCode: 500,
    );
    const cacheFailure = CacheFailure(message: 'Cache Error');
    const networkFailure = NetworkFailure(message: 'No Internet');

    test('Failures should stringify correctly', () {
      expect(generalFailure.stringify, isTrue); // ✅ Covers `stringify`
      expect(serverFailure.stringify, isTrue);
      expect(cacheFailure.stringify, isTrue);
      expect(networkFailure.stringify, isTrue);
    });

    test('Base Failure class toString should return message', () {
      expect(generalFailure.toString(), 'Something went wrong');
      expect(serverFailure.toString(), 'Server Error');
      expect(cacheFailure.toString(), 'Cache Error');
      expect(networkFailure.toString(), 'No Internet');
    });

    test('Failures should have correct props', () {
      expect(generalFailure.props, [
        'Something went wrong',
      ]); // ✅ Covers `props`
      expect(serverFailure.props, ['Server Error']); // ✅ Covers `props`
      expect(cacheFailure.props, ['Cache Error']); // ✅ Covers `props`
      expect(networkFailure.props, ['No Internet']); // ✅ Covers `props`
    });
  });
}
