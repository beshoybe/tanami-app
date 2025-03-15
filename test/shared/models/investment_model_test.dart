import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/shared/models/investment_model.dart';

void main() {
  group('InvestmentModel', () {
    final investmentJson = {
      'name': 'Real Estate',
      'expected_return': '10%',
      'duration': '5 years',
      'pdf_link': 'https://example.com/investment.pdf',
      'image_url': 'https://example.com/image.jpg',
    };

    test('should correctly parse from JSON', () {
      final model = InvestmentModel.fromJson(investmentJson);

      expect(model.name, 'Real Estate');
      expect(model.expectedReturn, '10%');
      expect(model.duration, '5 years');
      expect(model.pdfLink, 'https://example.com/investment.pdf');
      expect(model.image, 'https://example.com/image.jpg');
    });

    test('should correctly convert to JSON', () {
      final model = InvestmentModel.fromJson(investmentJson);
      final json = model.toJson();

      expect(json, investmentJson);
    });
  });
}
