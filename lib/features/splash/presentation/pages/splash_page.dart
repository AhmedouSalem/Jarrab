import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jarrab/core/routing/app_router.dart';
import 'package:jarrab/core/constant/app_image_asset.dart';
import 'package:jarrab/features/splash/presentation/widgets/gradient_progress_bar.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Animation progressive (0 -> 1)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    )..forward();

    // Navigation après ~6200s
    _timer = Timer(const Duration(milliseconds: 6200), () {
      if (!mounted) return;
      context.go(Routes.home);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Couleurs
    final Color primary = Theme.of(context).colorScheme.primaryContainer;
    final Color secondary = Theme.of(context).colorScheme.secondaryContainer;
    final bg = Theme.of(context).colorScheme.surface;
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withValues(alpha: 0.22),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Image.asset(AppImageAsset.appLogo, fit: BoxFit.cover),
              ),

              const SizedBox(height: 22),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return GradientProgressBar(
                    value: _controller.value,
                    height: 6,
                    width: 220,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.08),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [primary, secondary],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
