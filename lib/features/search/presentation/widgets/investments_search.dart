import 'package:flutter/material.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';

class InvestmentsSearch extends StatelessWidget {
  const InvestmentsSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.w(42),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: context.appTheme.white,
                borderRadius: BorderRadius.circular(context.w(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(
                      (0.1 * 255).toInt(),
                    ), // Equivalent to #0000001A
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: SearchBar(
                backgroundColor: WidgetStateProperty.all(
                  context.appTheme.white,
                ),
                elevation: WidgetStateProperty.all(
                  0,
                ), // Matches the blur effect
                leading: Assets.svg.search.svg(),

                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.w(12)),
                  ),
                ),
                hintText: context.tr.searchHint,
                hintStyle: WidgetStateProperty.all(
                  TextStyle(color: context.appTheme.normal, fontSize: 14),
                ),
                onChanged: (value) {},
              ),
            ),
          ),
          SizedBox(width: context.w(8)), // Space between search and button
          Container(
            decoration: BoxDecoration(
              color: context.appTheme.white,
              borderRadius: BorderRadius.circular(context.w(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(
                    (0.1 * 255).toInt(),
                  ), // Equivalent to #0000001A
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: AppButton(
              padding: EdgeInsets.all(context.w(4)),
              width: context.w(42),
              height: context.w(42),

              child: Assets.svg.filter.svg(
                width: context.w(24),
                height: context.w(24),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
