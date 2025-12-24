import 'package:flutter/material.dart';
import '../../domain/entities/leaderboard_entry.dart';

class LeaderboardTopCard extends StatelessWidget {
  const LeaderboardTopCard({
    super.key,
    required this.first,
    required this.second,
    required this.third,
  });

  final LeaderboardEntry? first;
  final LeaderboardEntry? second;
  final LeaderboardEntry? third;

  String _fmt(int v) {
    final s = v.toString();
    return s.replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: cs.primary.withValues(alpha: 0.10),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _PodiumUser(
                  rank: '2',
                  name: second?.displayName ?? '',
                  score: _fmt(second?.score ?? 0),
                  isCenter: false,
                  avatarBg: cs.surfaceContainerHighest,
                  iconColor: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PodiumUser(
                  rank: '',
                  name: first?.displayName ?? '',
                  score: _fmt(first?.score ?? 0),
                  isCenter: true,
                  avatarBg: cs.primary.withValues(alpha: 0.14),
                  iconColor: cs.primaryContainer,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PodiumUser(
                  rank: '3',
                  name: third?.displayName ?? '',
                  score: _fmt(third?.score ?? 0),
                  isCenter: false,
                  avatarBg: cs.surfaceContainerHighest,
                  iconColor: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PodiumUser extends StatelessWidget {
  const _PodiumUser({
    required this.rank,
    required this.name,
    required this.score,
    required this.isCenter,
    required this.avatarBg,
    required this.iconColor,
  });

  final String rank;
  final String name;
  final String score;
  final bool isCenter;
  final Color avatarBg;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        if (rank.isNotEmpty)
          Text(rank, style: TextStyle(color: cs.onSurfaceVariant, fontWeight: FontWeight.w800)),
        if (rank.isNotEmpty) const SizedBox(height: 6),

        Container(
          width: isCenter ? 56 : 48,
          height: isCenter ? 56 : 48,
          decoration: BoxDecoration(
            color: avatarBg,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.person, color: iconColor),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          score,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: cs.primaryContainer,
          ),
        ),
      ],
    );
  }
}
