import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/shared/entities/user_entity.dart';

void main() {
  group('UserEntity', () {
    test('should correctly initialize with given values', () {
      const user = UserEntity(
        id: '123',
        name: 'John Doe',
        email: 'johndoe@example.com',
      );

      expect(user.id, '123');
      expect(user.name, 'John Doe');
      expect(user.email, 'johndoe@example.com');
    });

    test('should support value equality', () {
      const user1 = UserEntity(
        id: '456',
        name: 'Alice Smith',
        email: 'alice@example.com',
      );

      const user2 = UserEntity(
        id: '456',
        name: 'Alice Smith',
        email: 'alice@example.com',
      );

      expect(user1, equals(user2));
    });

    test('should have correct props for Equatable', () {
      const user = UserEntity(
        id: '789',
        name: 'Bob Brown',
        email: 'bob@example.com',
      );

      expect(user.props, ['789', 'Bob Brown', 'bob@example.com']);
    });
  });
}
