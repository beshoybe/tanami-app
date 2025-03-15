import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/shared/models/user_model.dart';

void main() {
  group('UserModel', () {
    final userJson = {
      'id': '123',
      'name': 'John Doe',
      'email': 'john.doe@example.com',
    };

    test('should correctly parse from JSON', () {
      final model = UserModel.fromJson(userJson);

      expect(model.id, '123');
      expect(model.name, 'John Doe');
      expect(model.email, 'john.doe@example.com');
    });

    test('should correctly convert to JSON', () {
      final model = UserModel.fromJson(userJson);
      final json = model.toJson();

      expect(json, userJson);
    });
  });
}
