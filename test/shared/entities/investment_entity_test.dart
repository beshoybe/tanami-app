import 'package:flutter_test/flutter_test.dart';
import 'package:tanami_capital/shared/entities/investment_entity.dart';

void main() {
  group('InvestmentEntity', () {
    test('should correctly initialize with given values', () {
      const investment = InvestmentEntity(
        name: 'Real Estate Fund',
        expectedReturn: '8%',
        duration: '5 years',
        pdfLink: 'https://example.com/details.pdf',
        image: 'https://example.com/image.jpg',
      );

      expect(investment.name, 'Real Estate Fund');
      expect(investment.expectedReturn, '8%');
      expect(investment.duration, '5 years');
      expect(investment.pdfLink, 'https://example.com/details.pdf');
      expect(investment.image, 'https://example.com/image.jpg');
    });

    test('should support value equality', () {
      const investment1 = InvestmentEntity(
        name: 'Crypto Investment',
        expectedReturn: '15%',
        duration: '3 years',
        pdfLink: 'https://example.com/crypto.pdf',
        image: 'https://example.com/crypto.jpg',
      );

      const investment2 = InvestmentEntity(
        name: 'Crypto Investment',
        expectedReturn: '15%',
        duration: '3 years',
        pdfLink: 'https://example.com/crypto.pdf',
        image: 'https://example.com/crypto.jpg',
      );

      expect(investment1, equals(investment2));
    });

    test('should have correct props for Equatable', () {
      const investment = InvestmentEntity(
        name: 'Tech Startup Fund',
        expectedReturn: '12%',
        duration: '7 years',
        pdfLink: 'https://example.com/tech.pdf',
        image: 'https://example.com/tech.jpg',
      );

      expect(investment.props, [
        'Tech Startup Fund',
        '12%',
        '7 years',
        'https://example.com/tech.pdf',
        'https://example.com/tech.jpg',
      ]);
    });
  });
}
