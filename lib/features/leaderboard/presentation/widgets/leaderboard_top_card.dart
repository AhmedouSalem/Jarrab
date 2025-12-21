import 'package:flutter/material.dart';

class LeaderboardTopCard extends StatelessWidget {
  const LeaderboardTopCard({super.key});

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
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events_outlined, color: cs.primaryContainer),
              const SizedBox(width: 6),
              Text(
                '1',
                style: TextStyle(
                  color: cs.primaryContainer,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _PodiumUser(
                  rank: '2',
                  name: 'Liam Smith',
                  score: '11,800',
                  isCenter: false,
                  avatarBg: cs.secondaryContainer.withValues(alpha: 0.45),
                  iconColor: cs.primaryContainer,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PodiumUser(
                  rank: '',
                  name: 'Ava Johnson',
                  score: '12,500',
                  isCenter: true,
                  avatarBg: cs.primary.withValues(alpha: 0.14),
                  iconColor: cs.primaryContainer,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PodiumUser(
                  rank: '3',
                  name: '',
                  score: '10,200',
                  isCenter: false,
                  avatarBg: cs.surfaceContainerHighest,
                  iconColor: cs.primaryContainer,
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

    final rankStyle = TextStyle(
      color: cs.onSurface,
      fontWeight: FontWeight.w800,
      fontSize: isCenter ? 16 : 14,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (rank.isNotEmpty) ...[
          Text(rank, style: rankStyle),
          const SizedBox(height: 6),
        ] else
          const SizedBox(height: 22),

        CircleAvatar(
          radius: isCenter ? 34 : 26,
          backgroundColor: avatarBg,
          child: Icon(Icons.person, color: iconColor),
        ),
        const SizedBox(height: 10),

        if (name.isNotEmpty)
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: cs.onSurface,
              fontWeight: isCenter ? FontWeight.w800 : FontWeight.w600,
              fontSize: isCenter ? 15 : 13,
            ),
          )
        else
          const SizedBox(height: 18),

        const SizedBox(height: 6),

        Text(
          score,
          style: TextStyle(
            color: cs.primaryContainer,
            fontWeight: FontWeight.w800,
            fontSize: isCenter ? 20 : 16,
          ),
        ),
      ],
    );
  }
}
