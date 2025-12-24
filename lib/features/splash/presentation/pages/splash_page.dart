import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:jarrab/core/constant/app_image_asset.dart';
import 'package:jarrab/core/di/injection.dart';
import 'package:jarrab/core/routing/routes.dart';

import 'package:jarrab/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:jarrab/features/splash/presentation/bloc/splash_event.dart';
import 'package:jarrab/features/splash/presentation/bloc/splash_state.dart';
import 'package:jarrab/features/splash/presentation/widgets/gradient_progress_bar.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final primary = cs.primaryContainer;
    final secondary = cs.secondaryContainer;

    return BlocProvider(
      create: (_) => Injection.I.createSplashBloc()..add(const SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listenWhen: (_, next) => next is SplashReady,
        listener: (context, state) {
          context.go(Routes.home);
        },
        child: Scaffold(
          backgroundColor: cs.surface,
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
                        backgroundColor: cs.onSurface.withValues(alpha: 0.08),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [primary, secondary],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<SplashBloc, SplashState>(
                    builder: (context, state) {
                      if (state is SplashLoading) {
                        return Text(
                          state.message,
                          style: TextStyle(
                            color: cs.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
