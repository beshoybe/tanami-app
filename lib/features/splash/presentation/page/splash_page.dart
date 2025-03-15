import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/features/splash/presentation/provider/splash_provider.dart';
import 'package:tanami_capital/features/splash/presentation/provider/splash_states.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Repeats the fade in and out effect

    _animation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage(Assets.jpg.auth.path), context);
    precacheImage(AssetImage(Assets.jpg.user.path), context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(splashProvider);
    ref.listen(splashProvider, (_, next) {
      if (next is SplashLoadedState) {
        AuthOptionsRoute().go(context);
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Assets.svg.logo.svg(),
        ),
      ),
    );
  }
}
