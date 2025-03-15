import 'package:equatable/equatable.dart';

class InvestmentEntity extends Equatable {
  final String name;
  final String expectedReturn;
  final String duration;
  final String pdfLink;
  final String image;

  const InvestmentEntity({
    required this.name,
    required this.expectedReturn,
    required this.duration,
    required this.pdfLink,
    required this.image,
  });

  @override
  List<Object?> get props => [name, expectedReturn, duration, pdfLink, image];
}
