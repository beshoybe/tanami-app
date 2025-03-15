import 'package:flutter/material.dart';
import 'package:tanami_capital/core/responsive/responsive_size.dart';

extension ResponsiveExtensions on BuildContext {
  double w(double w) => ResponsiveSize().scaleWidth(w, this);
  double h(double h) => ResponsiveSize().scaleHeight(h, this);
}
