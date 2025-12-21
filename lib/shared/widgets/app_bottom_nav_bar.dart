import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:jarrab/l10n/app_localizations.dart';

class AppBottomNavBar extends StatefulWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar>
    with TickerProviderStateMixin {
  late final MotionTabBarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MotionTabBarController(
      initialIndex: widget.currentIndex,
      length: 4,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(covariant AppBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si la route change (ex: context.go), on synchronise la barre visuellement.
    if (oldWidget.currentIndex != widget.currentIndex) {
      _controller.index = widget.currentIndex;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final labels = <String>[
      l10n.navHome,
      l10n.navLeaderboard,
      l10n.navProfile,
      l10n.navSettings,
    ];

    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final surface = theme.colorScheme.surfaceBright;

    return MotionTabBar(
      controller: _controller,
      initialSelectedTab: labels[widget.currentIndex],

      labels: labels,
      icons: const [
        Icons.home_outlined,
        Icons.emoji_events_outlined,
        Icons.person_outline,
        Icons.settings_outlined,
      ],

      useSafeArea: true,
      labelAlwaysVisible: false,
      tabBarHeight: 62,
      tabSize: 52,
      tabIconSize: 26,
      tabIconSelectedSize: 28,

      tabBarColor: surface,
      tabSelectedColor: primary,
      tabIconColor: theme.iconTheme.color,
      tabIconSelectedColor: theme.colorScheme.surface,
      textStyle: theme.textTheme.labelSmall!.copyWith(
        color: primary,
        fontWeight: FontWeight.w900,
      ),

      onTabItemSelected: (index) {
        widget.onTap(index);
        _controller.index = index;
      },
    );
  }
}
