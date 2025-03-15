import 'package:tanami_capital/shared/entities/investment_entity.dart';

class InvestmentModel extends InvestmentEntity {
  const InvestmentModel({
    required super.name,
    required super.expectedReturn,
    required super.duration,
    required super.pdfLink,
    required super.image,
  });

  factory InvestmentModel.fromJson(Map<String, dynamic> json) {
    return InvestmentModel(
      name: json['name'],
      expectedReturn: json['expected_return'],
      duration: json['duration'],
      pdfLink: json['pdf_link'],
      image: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'expected_return': expectedReturn,
      'duration': duration,
      'pdf_link': pdfLink,
      'image_url': image,
    };
  }
}
