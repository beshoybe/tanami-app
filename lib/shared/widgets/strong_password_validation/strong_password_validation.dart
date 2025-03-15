import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/shared/widgets/strong_password_validation/strong_password_validation_provider.dart';

class StrongPasswordValidation extends ConsumerWidget {
  const StrongPasswordValidation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(strongPasswordValidationProvider.notifier);
    ref.watch(strongPasswordValidationProvider);
    final numberOfValidations = provider.numberOfValidations();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.h(12)),
        Row(
          children: List.generate(
            4,
            (index) => Expanded(
              child: _indicatorBarItem(
                index < numberOfValidations && numberOfValidations > 0,
                context,
              ),
            ),
          ),
        ),
        SizedBox(height: context.h(4)),

        Text(context.tr.passwordMustHave, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 8),

        _mustHaveItem(context, context.tr.ulcletters, provider.hasLetters),
        _mustHaveItem(
          context,
          context.tr.specialCharacters,
          provider.hasSpecialCharacters,
        ),
        _mustHaveItem(context, context.tr.numbers, provider.hasDigits),
        _mustHaveItem(context, context.tr.minLength, provider.hasMinLength),
      ],
    );
  }

  /// Animated must-have item
  Widget _mustHaveItem(BuildContext context, String text, bool condition) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Icon(
            Icons.circle,
            color: condition ? Colors.green : Colors.grey,
            size: context.w(8),
          ),
        ),
        SizedBox(width: context.w(4)),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            fontSize: 10,
            color: condition ? Colors.green : Colors.grey,
          ),
          child: Text(text),
        ),
      ],
    );
  }

  /// Animated indicator bar item
  Widget _indicatorBarItem(bool condition, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: 2),
      width: double.infinity,
      height: context.h(2),
      decoration: BoxDecoration(
        color: condition ? Colors.green : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
