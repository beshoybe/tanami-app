import 'package:flutter/material.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String content;
  final Widget action;
  final Color? backgroundColor;
  final Color? textColor;

  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    required this.action,
    this.backgroundColor,
    this.textColor,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String content,
    required Widget action,
    Color? backgroundColor,
    Color? textColor,
  }) async {
    return showDialog(
      context: context,
      builder:
          (context) => AppDialog(
            title: title,
            content: content,
            action: action,
            backgroundColor: backgroundColor,
            textColor: textColor,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.w(8)),
      ),
      backgroundColor: backgroundColor ?? context.appTheme.white,
      child: Padding(
        padding: EdgeInsets.all(context.w(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor ?? context.appTheme.normal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: textColor ?? context.appTheme.normal,
              ),
            ),
            const SizedBox(height: 16),
            action,
          ],
        ),
      ),
    );
  }
}
