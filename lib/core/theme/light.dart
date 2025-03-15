import 'package:flutter/material.dart';
import 'package:tanami_capital/core/theme/base.dart';
import 'package:tanami_capital/gen/assets/fonts.gen.dart';

class LightThemeExtension extends BaseTheme {
  const LightThemeExtension({super.locale})
    : super(
        light: const Color(0xffE6EAE7),
        lightHover: const Color(0xffD9E0DB),
        lightActive: const Color(0xffB0BFB5),
        normal: const Color(0xff002F0F),
        normalHover: const Color(0xff002A0E),
        normalActive: const Color(0xff00260C),
        dark: const Color(0xff00230B),
        darkHover: const Color(0xff001C09),
        darkActive: const Color(0xff001507),
        darker: const Color(0xff001005),
        white: const Color(0xffFFFFFF),
        black: const Color(0xff000000),
        border: const Color(0xffEFF0F6),
        border2: const Color(0xffEDF1F3),
        gray: const Color(0xff6C7278),
      );

  ThemeData get theme => ThemeData(
    fontFamily:
        locale.languageCode == 'ar' ? FontFamily.oxygen : FontFamily.poppins,
    primaryColor: normal,
    scaffoldBackgroundColor: white,

    extensions: {this},
  );
}
