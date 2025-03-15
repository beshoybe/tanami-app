import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/shared/models/investment_history_model.dart';

void main() {
  group('InvestmentHistoryModel', () {
    final historyJson = {'month': 'January', 'profit': 1000.5, 'loss': 200.0};

    test('should correctly parse from JSON', () {
      final model = InvestmentHistoryModel.fromJson(historyJson);

      expect(model.month, 'January');
      expect(model.profit, 1000.5);
      expect(model.loss, 200.0);
    });

    test('should correctly convert to JSON', () {
      final model = InvestmentHistoryModel.fromJson(historyJson);
      final json = model.toJson();

      expect(json, historyJson);
    });
  });
}
