import 'package:flutter/material.dart';
import 'package:jarrab/core/ui/responsive.dart';

import '../widgets/leaderboard_period_toggle.dart';
import '../widgets/leaderboard_top_card.dart';
import '../widgets/leaderboard_rank_tile.dart';
import '../widgets/leaderboard_you_tile.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tileHeight = LeaderboardRankTile.height(context);
    final spacing = Responsive.pick(
      context,
      compact: 12.0,
      medium: 14.0,
      expanded: 16.0,
    );
    final horizontalPadding = Responsive.pick<double>(
      context,
      compact: 0,
      medium: 24,
      expanded: 32,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Leaderboard',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LeaderboardPeriodToggle(),
                      SizedBox(height: 16),

                      LeaderboardTopCard(),
                      SizedBox(height: 14),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: tileHeight),
                            height: tileHeight * 1 + spacing,
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: 10,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: spacing),
                              itemBuilder: (context, index) {
                                return LeaderboardRankTile(
                                  rank: (8 + index).toString(),
                                  name: index.isEven
                                      ? 'Martinez'
                                      : 'Isabella\nHernandez',
                                  score: index.isEven ? '8,300' : '7,900',
                                );
                              },
                            ),
                          ),

                          LeaderboardYouTile(
                            label: 'You — #12',
                            name: 'You',
                            score: '6,800',
                          ),
                        ],
                      ),
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
