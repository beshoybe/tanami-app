import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/features/home/presentation/provider/home_provider.dart';
import 'package:tanami_capital/features/home/presentation/widgets/home_header.dart';
import 'package:tanami_capital/features/home/presentation/widgets/investment_opportunities.dart';
import 'package:tanami_capital/features/home/presentation/widgets/investment_summary.dart';
import 'package:tanami_capital/features/home/presentation/widgets/quick_action.dart';
import 'package:tanami_capital/shared/widgets/app_error.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(20)),
          child: ref
              .watch(homeDataProvider)
              .when(
                skipLoadingOnRefresh: false,
                data: (data) {
                  return RefreshIndicator(
                    color: context.appTheme.normal,
                    backgroundColor: context.appTheme.white,
                    onRefresh: () async => ref.invalidate(homeDataProvider),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomeHeader(user: data.user),
                          SizedBox(height: context.h(24)),
                          InvestmentSummary(
                            investmentHistories: data.investmentHistories,
                            totalInvestments: data.totalInvestments,
                            max: data.max,
                            min: data.min,
                          ),
                          SizedBox(height: context.h(24)),
                          QuickActions(),
                          SizedBox(height: context.h(24)),
                          InvestmentOpportunities(
                            investments: data.bestInvestments,
                          ),
                          SizedBox(height: context.h(84)),
                        ],
                      ),
                    ),
                  );
                },
                error: (e, st) {
                  return AppError(
                    error: e,
                    onRetry: () => ref.invalidate(homeDataProvider),
                  );
                },
                loading:
                    () => Center(
                      child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation(
                          context.appTheme.normal,
                        ),
                      ),
                    ),
              ),
        ),
      ),
    );
  }
}
