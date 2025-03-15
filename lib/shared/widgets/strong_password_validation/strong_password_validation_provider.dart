import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final strongPasswordValidationProvider = ChangeNotifierProvider.autoDispose(
  (ref) => StrongPasswordValidationProvider(),
);

class StrongPasswordValidationProvider extends ChangeNotifier {
  bool _hasLetters = false;
  bool _hasDigits = false;
  bool _hasSpecialCharacters = false;
  bool _hasMinLength = false;

  bool get hasLetters => _hasLetters;
  bool get hasDigits => _hasDigits;
  bool get hasSpecialCharacters => _hasSpecialCharacters;
  bool get hasMinLength => _hasMinLength;

  void validatePassword(String password) {
    _hasLetters =
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]'));
    _hasDigits = password.contains(RegExp(r'[0-9]'));
    _hasSpecialCharacters = password.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    );
    _hasMinLength = password.length >= 6;

    notifyListeners();
  }

  int numberOfValidations() {
    int count = 0;
    if (_hasLetters) count++;
    if (_hasDigits) count++;
    if (_hasSpecialCharacters) count++;
    if (_hasMinLength) count++;

    return count;
  }
}
