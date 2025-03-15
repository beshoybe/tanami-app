// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'base.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$BaseThemeTailorMixin on ThemeExtension<BaseTheme> {
  Color get light;
  Color get lightHover;
  Color get lightActive;
  Color get normal;
  Color get normalHover;
  Color get normalActive;
  Color get dark;
  Color get darkHover;
  Color get darkActive;
  Color get darker;
  Color get white;
  Color get black;
  Color get border;
  Color get border2;
  Color get gray;
  Locale get locale;

  @override
  BaseTheme copyWith({
    Color? light,
    Color? lightHover,
    Color? lightActive,
    Color? normal,
    Color? normalHover,
    Color? normalActive,
    Color? dark,
    Color? darkHover,
    Color? darkActive,
    Color? darker,
    Color? white,
    Color? black,
    Color? border,
    Color? border2,
    Color? gray,
    Locale? locale,
  }) {
    return BaseTheme(
      light: light ?? this.light,
      lightHover: lightHover ?? this.lightHover,
      lightActive: lightActive ?? this.lightActive,
      normal: normal ?? this.normal,
      normalHover: normalHover ?? this.normalHover,
      normalActive: normalActive ?? this.normalActive,
      dark: dark ?? this.dark,
      darkHover: darkHover ?? this.darkHover,
      darkActive: darkActive ?? this.darkActive,
      darker: darker ?? this.darker,
      white: white ?? this.white,
      black: black ?? this.black,
      border: border ?? this.border,
      border2: border2 ?? this.border2,
      gray: gray ?? this.gray,
      locale: locale ?? this.locale,
    );
  }

  @override
  BaseTheme lerp(covariant ThemeExtension<BaseTheme>? other, double t) {
    if (other is! BaseTheme) return this as BaseTheme;
    return BaseTheme(
      light: Color.lerp(light, other.light, t)!,
      lightHover: Color.lerp(lightHover, other.lightHover, t)!,
      lightActive: Color.lerp(lightActive, other.lightActive, t)!,
      normal: Color.lerp(normal, other.normal, t)!,
      normalHover: Color.lerp(normalHover, other.normalHover, t)!,
      normalActive: Color.lerp(normalActive, other.normalActive, t)!,
      dark: Color.lerp(dark, other.dark, t)!,
      darkHover: Color.lerp(darkHover, other.darkHover, t)!,
      darkActive: Color.lerp(darkActive, other.darkActive, t)!,
      darker: Color.lerp(darker, other.darker, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      border: Color.lerp(border, other.border, t)!,
      border2: Color.lerp(border2, other.border2, t)!,
      gray: Color.lerp(gray, other.gray, t)!,
      locale: t < 0.5 ? locale : other.locale,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BaseTheme &&
            const DeepCollectionEquality().equals(light, other.light) &&
            const DeepCollectionEquality()
                .equals(lightHover, other.lightHover) &&
            const DeepCollectionEquality()
                .equals(lightActive, other.lightActive) &&
            const DeepCollectionEquality().equals(normal, other.normal) &&
            const DeepCollectionEquality()
                .equals(normalHover, other.normalHover) &&
            const DeepCollectionEquality()
                .equals(normalActive, other.normalActive) &&
            const DeepCollectionEquality().equals(dark, other.dark) &&
            const DeepCollectionEquality().equals(darkHover, other.darkHover) &&
            const DeepCollectionEquality()
                .equals(darkActive, other.darkActive) &&
            const DeepCollectionEquality().equals(darker, other.darker) &&
            const DeepCollectionEquality().equals(white, other.white) &&
            const DeepCollectionEquality().equals(black, other.black) &&
            const DeepCollectionEquality().equals(border, other.border) &&
            const DeepCollectionEquality().equals(border2, other.border2) &&
            const DeepCollectionEquality().equals(gray, other.gray) &&
            const DeepCollectionEquality().equals(locale, other.locale));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(light),
      const DeepCollectionEquality().hash(lightHover),
      const DeepCollectionEquality().hash(lightActive),
      const DeepCollectionEquality().hash(normal),
      const DeepCollectionEquality().hash(normalHover),
      const DeepCollectionEquality().hash(normalActive),
      const DeepCollectionEquality().hash(dark),
      const DeepCollectionEquality().hash(darkHover),
      const DeepCollectionEquality().hash(darkActive),
      const DeepCollectionEquality().hash(darker),
      const DeepCollectionEquality().hash(white),
      const DeepCollectionEquality().hash(black),
      const DeepCollectionEquality().hash(border),
      const DeepCollectionEquality().hash(border2),
      const DeepCollectionEquality().hash(gray),
      const DeepCollectionEquality().hash(locale),
    );
  }
}
