import 'package:flutter/material.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/auth_header_image.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';
import 'package:tanami_capital/shared/widgets/change_lang/change_lang_button.dart';

class MainAuthLayout extends StatelessWidget {
  final Widget child;
  final String? mainTitle;
  final String? subTitle;
  const MainAuthLayout({
    super.key,
    required this.child,
    this.mainTitle,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              AuthHeaderImage(),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.w(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.h(50)),
                      Assets.svg.logo.svg(width: context.w(100)),
                      const SizedBox(height: 14),
                      Text(
                        mainTitle ?? context.tr.getStarted,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subTitle ?? context.tr.getStartedHeader,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: context.h(40),
                    end: context.w(20),
                  ),
                  child: ChangeLangButton(),
                ),
              ),
            ],
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
