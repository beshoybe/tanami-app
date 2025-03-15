import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/change_lang/change_lang_sheet.dart';

class ChangeLangButton extends ConsumerWidget {
  const ChangeLangButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppButton(
      padding: EdgeInsets.zero,
      width: context.w(40),
      height: context.h(40),

      child: Center(child: Icon(Icons.language, size: context.w(20))),
      onPressed: () => ChangeLangSheet.show(context),
    );
  }
}
