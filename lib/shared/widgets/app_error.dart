import 'package:flutter/material.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';

class AppError extends StatelessWidget {
  final Object? error;
  final VoidCallback? onRetry;
  const AppError({super.key, this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final message =
        error is ServerFailure ? (error as ServerFailure).message : null;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.svg.error.svg(
            width: context.w(100),
            height: context.h(100),
            colorFilter: ColorFilter.mode(
              context.appTheme.normal,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: context.h(16)),
          Text(
            message ?? context.tr.errorOccured,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: context.h(16)),
            AppButton(
              color: context.appTheme.normal,
              onPressed: onRetry,
              child: Text(
                context.tr.retry,
                style: TextStyle(color: context.appTheme.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
