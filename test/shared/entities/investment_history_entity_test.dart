import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/shared/entities/investment_history_entity.dart';

void main() {
  group('InvestmentHistoryEntity', () {
    test('should correctly initialize with given values', () {
      const history = InvestmentHistoryEntity(
        month: 'January',
        profit: 500.0,
        loss: 100.0,
      );

      expect(history.month, 'January');
      expect(history.profit, 500.0);
      expect(history.loss, 100.0);
    });

    test('should support value equality', () {
      const history1 = InvestmentHistoryEntity(
        month: 'February',
        profit: 750.0,
        loss: 50.0,
      );

      const history2 = InvestmentHistoryEntity(
        month: 'February',
        profit: 750.0,
        loss: 50.0,
      );

      expect(history1, equals(history2));
    });

    test('should have correct props for Equatable', () {
      const history = InvestmentHistoryEntity(
        month: 'March',
        profit: 300.0,
        loss: 20.0,
      );

      expect(history.props, ['March', 300.0, 20.0]);
    });
  });
}
