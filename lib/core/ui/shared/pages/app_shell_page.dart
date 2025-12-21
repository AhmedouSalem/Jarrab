import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jarrab/core/routing/app_router.dart';
import 'package:jarrab/core/ui/responsive.dart';
import 'package:jarrab/core/ui/shared/widgets/app_bottom_nav_bar.dart';

class AppShellPage extends StatelessWidget {
  const AppShellPage({
    super.key,
    required this.child,
    this.useHorizontalPadding = true,
  });

  final Widget child;
  final bool useHorizontalPadding;

  int _indexFromLocation(String location) {
    if (location.startsWith(Routes.home)) return 0;
    if (location.startsWith(Routes.leaderboard)) return 1;
    if (location.startsWith(Routes.profile)) return 2;
    if (location.startsWith(Routes.settings)) return 3;
    return 0;
  }

  void _goFromIndex(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(Routes.home);
        return;
      case 1:
        context.go(Routes.leaderboard);
        return;
      case 2:
        context.go(Routes.profile);
        return;
      case 3:
        context.go(Routes.settings);
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.pick<double>(
      context,
      compact: 520,
      medium: 720,
      expanded: 920,
    );

    final horizontalPadding = Responsive.pick<double>(
      context,
      compact: 16,
      medium: 24,
      expanded: 32,
    );

    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _indexFromLocation(location);

    Widget content = child;

    if (useHorizontalPadding) {
      content = Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: content,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: content,
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
        onTap: (i) => _goFromIndex(context, i),
      ),
    );
  }
}
