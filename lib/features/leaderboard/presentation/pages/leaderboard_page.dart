import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jarrab/core/ui/responsive.dart';

import '../bloc/leaderboard_bloc.dart';
import '../bloc/leaderboard_event.dart';
import '../bloc/leaderboard_state.dart';
import '../widgets/leaderboard_period_toggle.dart';
import '../widgets/leaderboard_rank_tile.dart';
import '../widgets/leaderboard_top_card.dart';
import '../widgets/leaderboard_you_tile.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  String _fmt(int v) {
    final s = v.toString();
    return s.replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tileHeight = LeaderboardRankTile.height(context);
    final spacing = Responsive.pick(context, compact: 12.0, medium: 14.0, expanded: 16.0);
    final horizontalPadding = Responsive.pick<double>(context, compact: 0, medium: 24, expanded: 32);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
                child: Text(
                  'Leaderboard',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const Divider(height: 1),

              Expanded(
                child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
                  builder: (context, state) {
                    if (state is LeaderboardLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is LeaderboardError) {
                      return Center(child: Text(state.message));
                    }

                    final s = state as LeaderboardLoaded;

                    final top3 = s.top3;
                    final rest = s.rest;
                    final me = s.me;
                    final myRank = s.myRank;

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<LeaderboardBloc>().add(const LeaderboardRefreshed());
                      },
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                        children: [
                          LeaderboardPeriodToggle(
                            value: s.period,
                            onChanged: (p) => context.read<LeaderboardBloc>().add(LeaderboardPeriodChanged(p)),
                          ),
                          const SizedBox(height: 10),
                          if (s.isRefreshing) const LinearProgressIndicator(minHeight: 2),
                          if (!s.isRefreshing) const SizedBox(height: 2),
                          const SizedBox(height: 14),

                          LeaderboardTopCard(
                            first: top3.isNotEmpty ? top3[0] : null,
                            second: top3.length > 1 ? top3[1] : null,
                            third: top3.length > 2 ? top3[2] : null,
                          ),
                          const SizedBox(height: 14),

                          SizedBox(
                            height: 520,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: tileHeight),
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemCount: rest.length,
                                    separatorBuilder: (_, __) => SizedBox(height: spacing),
                                    itemBuilder: (context, index) {
                                      final e = rest[index];
                                      final rank = (4 + index).toString();
                                      return LeaderboardRankTile(
                                        rank: rank,
                                        name: e.displayName,
                                        score: _fmt(e.score),
                                      );
                                    },
                                  ),
                                ),
                                LeaderboardYouTile(
                                  label: myRank == null ? 'You' : 'You — #$myRank',
                                  name: me!.displayName,
                                  score: _fmt(me.score),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
