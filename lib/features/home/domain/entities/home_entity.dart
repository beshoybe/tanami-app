import 'package:equatable/equatable.dart';
import 'package:tanami_capital/shared/entities/investment_entity.dart';
import 'package:tanami_capital/shared/entities/investment_history_entity.dart';
import 'package:tanami_capital/shared/entities/user_entity.dart';

class HomeEntity extends Equatable {
  final UserEntity user;
  final List<InvestmentHistoryEntity> investmentHistories;
  final List<InvestmentEntity> bestInvestments;
  final double totalInvestments;
  final double max;
  final double min;

  const HomeEntity({
    required this.user,
    required this.investmentHistories,
    required this.bestInvestments,
    required this.totalInvestments,
    required this.max,
    required this.min,
  });

  @override
  List<Object?> get props => [user, investmentHistories, bestInvestments];
}
