import 'package:equatable/equatable.dart';

class InvestmentHistoryEntity extends Equatable {
  final String month;
  final double profit;
  final double loss;

  const InvestmentHistoryEntity({
    required this.month,
    required this.profit,
    required this.loss,
  });

  @override
  List<Object?> get props => [month, profit, loss];
}
