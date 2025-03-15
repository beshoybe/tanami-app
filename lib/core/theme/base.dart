import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'package:flutter/material.dart';

part 'base.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.none)
class BaseTheme extends ThemeExtension<BaseTheme> with _$BaseThemeTailorMixin {
  const BaseTheme({
    required this.light,
    required this.lightHover,
    required this.lightActive,
    required this.normal,
    required this.normalHover,
    required this.normalActive,
    required this.dark,
    required this.darkHover,
    required this.darkActive,
    required this.darker,
    required this.white,
    required this.black,
    required this.border,
    required this.border2,
    required this.gray,
    this.locale = const Locale('en'),
  });
  @override
  final Color light;
  @override
  final Color lightHover;
  @override
  final Color lightActive;
  @override
  final Color normal;
  @override
  final Color normalHover;
  @override
  final Color normalActive;
  @override
  final Color dark;
  @override
  final Color darkHover;
  @override
  final Color darkActive;
  @override
  final Color darker;
  @override
  final Color white;
  @override
  final Color black;

  @override
  final Color border;

  @override
  final Color border2;

  @override
  final Color gray;

  @override
  final Locale locale;
}
