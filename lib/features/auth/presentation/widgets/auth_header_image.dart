import 'package:flutter/material.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart'; // If using localization

class AuthHeaderImage extends StatelessWidget {
  const AuthHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isRTL = context.tr.localeName == 'ar';

    return Transform(
      alignment: Alignment.center,
      transform:
          isRTL
              ? Matrix4.rotationY(3.1416)
              : Matrix4.identity(), // Flip if Arabic
      child: Assets.jpg.authHeader.image(
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
