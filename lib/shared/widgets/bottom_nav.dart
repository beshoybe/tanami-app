import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).toInt()),
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
        border: Border.all(color: context.appTheme.light, width: context.w(1)),
        color: context.appTheme.white,
        borderRadius: BorderRadius.circular(context.w(12)),
      ),
      margin: EdgeInsets.all(context.w(20)),
      padding: EdgeInsets.symmetric(
        horizontal: context.w(8),
        vertical: context.h(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(context.tr.home, HomeRoute().location, context),
          _buildItem(context.tr.search, SearchRoute().location, context),
          _buildItem(
            context.tr.investments,
            InvestmentsRoute().location,
            context,
          ),
          _buildItem(context.tr.profile, ProfileRoute().location, context),
        ],
      ),
    );
  }

  Widget _buildItem(String title, String route, BuildContext context) {
    double expandedWidth = context.w(150);
    double collapsedWidth = context.w(50);
    bool isSelected = route == GoRouterState.of(context).uri.path;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isSelected ? expandedWidth : collapsedWidth,
      padding: EdgeInsets.symmetric(vertical: context.h(8)),
      decoration: BoxDecoration(
        color: isSelected ? context.appTheme.normal : Colors.transparent,
        borderRadius: BorderRadius.circular(context.w(8)),
      ),
      child: InkWell(
        onTap: () => GoRouter.of(context).go(route),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getIcon(route, isSelected),

            if (isSelected)
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: context.w(8)),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _getIcon(String page, bool isSelected) {
    switch (page.toLowerCase()) {
      case '/home':
        return Assets.svg.home.svg(
          width: context.w(20),
          height: context.w(20),
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.white : context.appTheme.normal,
            BlendMode.srcIn,
          ),
        );
      case '/search':
        return Assets.svg.search.svg(
          width: context.w(20),
          height: context.w(20),
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.white : context.appTheme.normal,
            BlendMode.srcIn,
          ),
        );
      case '/profile':
        return Assets.svg.profile.svg(
          width: context.w(20),
          height: context.w(20),
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.white : context.appTheme.normal,
            BlendMode.srcIn,
          ),
        );
      case '/investments':
        return Assets.svg.investments.svg(
          width: context.w(20),
          height: context.w(20),
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.white : context.appTheme.normal,
            BlendMode.srcIn,
          ),
        );
      default:
        return SizedBox();
    }
  }
}
