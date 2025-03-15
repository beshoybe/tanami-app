import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tanami_capital/features/auth/presentation/pages/auth_options_page.dart';
import 'package:tanami_capital/features/auth/presentation/pages/auth_page.dart';
import 'package:tanami_capital/features/auth/presentation/pages/confirm_otp_page.dart';
import 'package:tanami_capital/features/auth/presentation/pages/forget_password_page.dart';
import 'package:tanami_capital/features/auth/presentation/pages/login_page.dart';
import 'package:tanami_capital/features/auth/presentation/pages/reset_password_page.dart';
import 'package:tanami_capital/features/auth/presentation/pages/signup_page.dart';
import 'package:tanami_capital/features/home/presentation/pages/home_page.dart';
import 'package:tanami_capital/features/investments/investments_page.dart';
import 'package:tanami_capital/features/profile/profile_page.dart';
import 'package:tanami_capital/features/search/presentation/pages/search_page.dart';
import 'package:tanami_capital/features/settings/settings_screen.dart';
import 'package:tanami_capital/features/splash/presentation/page/splash_page.dart';
import 'package:tanami_capital/shared/widgets/screen_with_navbar.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

// Custom Fade Transition Page
class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({required super.child, required GoRouterState state})
    : super(
        key: state.pageKey,
        maintainState: true,
        transitionDuration: const Duration(milliseconds: 300), // Smooth fade
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
}

// Splash Route
@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends GoRouteData {
  static final GlobalKey<NavigatorState> $navigatorKey = rootNavigatorKey;

  @override
  Page buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(child: const SplashPage(), state: state);
  }
}

// Auth Options Route
@TypedGoRoute<AuthOptionsRoute>(path: '/auth-options')
class AuthOptionsRoute extends GoRouteData {
  final String? from;
  const AuthOptionsRoute({this.from});

  @override
  Page buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(child: AuthOptionsPage(from: from), state: state);
  }
}

// Auth Page Shell Route
@TypedShellRoute<AuthPageShellRoute>(
  routes: [
    TypedGoRoute<LoginRoute>(path: '/login'),
    TypedGoRoute<SignupRoute>(path: '/signup'),
  ],
)
class AuthPageShellRoute extends ShellRouteData {
  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Page pageBuilder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    return FadeTransitionPage(child: AuthPage(child: navigator), state: state);
  }
}

// Login Route
class LoginRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(child: LoginPage(), state: state);
  }
}

// Signup Route
class SignupRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(child: SignupPage(), state: state);
  }
}

@TypedGoRoute<ForgetPasswordRoute>(path: '/forget-password')
class ForgetPasswordRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(child: ForgetPasswordPage(), state: state);
  }
}

@TypedGoRoute<ConfirmOtpRoute>(path: '/confirm-otp')
class ConfirmOtpRoute extends GoRouteData {
  final String email;
  const ConfirmOtpRoute({required this.email});
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      child: ConfirmOtpPage(email: email),
      state: state,
    );
  }
}

@TypedGoRoute<ResetPasswordRoute>(path: '/reset-password')
class ResetPasswordRoute extends GoRouteData {
  final String token;

  const ResetPasswordRoute({required this.token});
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      child: ResetPasswordPage(token: token),
      state: state,
    );
  }
}

@TypedShellRoute<BaseRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(path: '/home'),
    TypedGoRoute<SearchRoute>(path: '/search'),
    TypedGoRoute<ProfileRoute>(path: '/profile'),
    TypedGoRoute<InvestmentsRoute>(path: '/investments'),
  ],
)
class BaseRoute extends ShellRouteData {
  @override
  Page pageBuilder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    return FadeTransitionPage(
      child: ScreenWithNavbar(child: navigator),
      state: state,
    );
  }
}

class HomeRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(child: HomePage(), state: state);
  }
}

class SearchRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(child: SearchPage(), state: state);
  }
}

class ProfileRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(child: ProfilePage(), state: state);
  }
}

class InvestmentsRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(child: InvestmentsPage(), state: state);
  }
}

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(child: SettingsScreen(), state: state);
  }
}
