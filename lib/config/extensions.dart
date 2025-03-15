import 'package:flutter/material.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';

extension ArabicNumber on BuildContext {
  String toArabicNumber(String number) {
    if (tr.localeName == 'en') return number.toString();
    String result = '';
    for (int i = 0; i < number.length; i++) {
      switch (number[i]) {
        case '0':
          result += '٠';
          break;
        case '1':
          result += '١';
          break;
        case '2':
          result += '٢';
          break;
        case '3':
          result += '٣';
          break;
        case '4':
          result += '٤';
          break;
        case '5':
          result += '٥';
          break;
        case '6':
          result += '٦';
          break;
        case '7':
          result += '٧';
          break;
        case '8':
          result += '٨';
          break;
        case '9':
          result += '٩';
          break;
        default:
          result += number[i];
      }
    }
    return result;
  }
}
