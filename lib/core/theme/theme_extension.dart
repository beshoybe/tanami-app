import 'package:flutter/material.dart';
import 'package:tanami_capital/core/theme/base.dart';

extension ThemeExtension on BuildContext {
  BaseTheme get appTheme => Theme.of(this).extension<BaseTheme>()!;
}
