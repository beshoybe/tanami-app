import 'package:flutter/material.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';

class AppButton extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Color? hoverColor;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool loading;
  final bool enabled;
  final Color? loadingColor;
  final BoxShadow? boxShadow;

  final void Function()? onPressed;
  const AppButton({
    super.key,
    this.color,
    required this.child,
    this.onPressed,
    this.borderColor,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.hoverColor,
    this.loading = false,
    this.enabled = true,
    this.loadingColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        color:
            color ?? context.appTheme.white, // Ensures no unwanted background
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: loading || !enabled ? null : onPressed,
          hoverColor: hoverColor ?? context.appTheme.lightHover,
          splashColor: hoverColor ?? context.appTheme.lightHover,
          overlayColor: WidgetStateProperty.all(
            hoverColor ?? context.appTheme.lightHover,
          ),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: padding ?? EdgeInsets.symmetric(horizontal: context.w(16)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: boxShadow != null ? [boxShadow!] : null,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor ?? context.appTheme.border),
            ),
            width: width ?? double.infinity,
            height: height ?? context.h(38),
            child:
                loading
                    ? SizedBox(
                      width: context.w(20),
                      height: context.w(20),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          loadingColor ?? context.appTheme.white,
                        ),
                        strokeWidth: 2,
                      ),
                    )
                    : child,
          ),
        ),
      ),
    );
  }
}
