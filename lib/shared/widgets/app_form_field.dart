import 'package:flutter/material.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';

class AppFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final String? error;
  final bool enabled;
  final String? hint;

  const AppFormField({
    super.key,
    required this.controller,
    this.label,
    this.validator,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.onChanged,
    this.error,
    this.enabled = true,
    this.hint,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  late bool obscureText;

  @override
  void initState() {
    obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(widget.label!, style: TextStyle(color: context.appTheme.gray)),
        SizedBox(height: context.h(4)),
        TextFormField(
          style: TextStyle(color: context.appTheme.normal, fontSize: 14),
          decoration: InputDecoration(
            hintText:
                widget.hint ??
                context.tr.enterYour(widget.label ?? ''.toLowerCase()),
            hintStyle: TextStyle(color: context.appTheme.gray, fontSize: 14),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.w(10)),
              borderSide: BorderSide(
                color: context.appTheme.border2,
                width: 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.w(10)),
              borderSide: BorderSide(
                color: context.appTheme.normalActive,
                width: 1.2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.w(10)),
              borderSide: BorderSide(
                color: context.appTheme.border2,
                width: 1.2,
              ),
            ),
            enabled: widget.enabled,
            contentPadding: EdgeInsets.all(10),

            errorText: widget.error,
            suffixIcon:
                widget.isPassword
                    ? Padding(
                      padding: EdgeInsets.all(context.w(4)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(context.w(20)),
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          size: context.w(20),
                          color: context.appTheme.gray,
                        ),
                      ),
                    )
                    : null,
          ),
          controller: widget.controller,
          validator: widget.validator,
          obscureText: obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
