import 'package:flutter/material.dart';
import 'package:jarrab/core/ui/responsive.dart';

import '../widgets/profile_header_card.dart';
import '../widgets/profile_stats_card.dart';
import '../widgets/profile_achievements_card.dart';
import '../widgets/profile_progress_card.dart';
import '../widgets/profile_recent_activity_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final horizontalPadding = Responsive.pick<double>(
      context,
      compact: 0,
      medium: 24,
      expanded: 32,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: cs.surfaceContainerLow,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
                child: Center(
                  child: Text(
                    'Profile',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ProfileHeaderCard(),
                      SizedBox(height: 14),
                      ProfileStatsCard(),
                      SizedBox(height: 14),
                      ProfileAchievementsCard(),
                      SizedBox(height: 14),
                      ProfileProgressCard(),
                      SizedBox(height: 14),
                      ProfileRecentActivityCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
