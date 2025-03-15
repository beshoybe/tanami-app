import 'package:flutter/material.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: context.appTheme.border)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w(8),
            vertical: context.h(8),
          ),
          child: Text(context.tr.or),
        ),
        Expanded(child: Divider(color: context.appTheme.border)),
      ],
    );
  }
}
