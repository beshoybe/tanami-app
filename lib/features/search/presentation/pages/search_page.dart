import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/features/search/presentation/provider/search_provider.dart';
import 'package:tanami_capital/features/search/presentation/widgets/investments_search.dart';
import 'package:tanami_capital/shared/widgets/app_error.dart';
import 'package:tanami_capital/shared/widgets/investment_card.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(16)),
          child: RefreshIndicator.adaptive(
            color: context.appTheme.normal,
            backgroundColor: context.appTheme.white,
            onRefresh: () async {
              ref.invalidate(allInvestmentsProvider);
            },
            child: Column(
              children: [
                SizedBox(height: context.h(16)),
                InvestmentsSearch(),
                SizedBox(height: context.h(20)),
                Expanded(
                  child: ref
                      .watch(allInvestmentsProvider)
                      .when(
                        skipLoadingOnRefresh: false,
                        data:
                            (data) => ListView.builder(
                              itemCount: data.length + 1,
                              itemBuilder: (context, index) {
                                if (index == data.length) {
                                  return SizedBox(height: context.h(80));
                                }
                                final investment = data[index];
                                return InvestmentCard(investment: investment);
                              },
                            ),
                        loading:
                            () => Center(
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation(
                                  context.appTheme.normal,
                                ),
                              ),
                            ),
                        error: (error, stackTrace) {
                          return AppError(
                            error: error,
                            onRetry: () {
                              ref.invalidate(allInvestmentsProvider);
                            },
                          );
                        },
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
