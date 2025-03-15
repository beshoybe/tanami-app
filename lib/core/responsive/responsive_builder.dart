import 'package:flutter/material.dart';
import 'package:tanami_capital/core/responsive/responsive_size.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Size figmaDesignSize;
  final Widget child;
  ResponsiveBuilder({
    super.key,
    required this.figmaDesignSize,
    required this.child,
  }) {
    ResponsiveSize().init(figmaDesignSize: figmaDesignSize);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(ResponsiveSize().scaleText(context)),
      ),
      child: child,
    );
  }
}
