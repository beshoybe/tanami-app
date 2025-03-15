import 'package:flutter/material.dart';

class ResponsiveSize {
  static final ResponsiveSize _instance = ResponsiveSize._internal();

  factory ResponsiveSize() => _instance;

  ResponsiveSize._internal();

  late Size _figmaDesignSize;

  void init({Size figmaDesignSize = const Size(375, 812)}) {
    _figmaDesignSize = figmaDesignSize;
  }

  double scaleWidth(double size, BuildContext context) =>
      size * (MediaQuery.of(context).size.width / _figmaDesignSize.width);

  double scaleHeight(double size, BuildContext context) =>
      size * (MediaQuery.of(context).size.height / _figmaDesignSize.height);

  double scaleText(BuildContext context) {
    final widthScale =
        MediaQuery.of(context).size.width / _figmaDesignSize.width;
    final heightScale =
        MediaQuery.of(context).size.height / _figmaDesignSize.height;
    return (widthScale + heightScale) / 2;
  }
}
