import 'package:flutter/material.dart';
import 'package:jarrab/core/ui/responsive.dart';

class LeaderboardRankTile extends StatelessWidget {
  const LeaderboardRankTile({
    super.key,
    required this.rank,
    required this.name,
    required this.score,
  });

  final String rank;
  final String name;
  final String score;

  static double height(BuildContext context) {
    return Responsive.pick(context, compact: 64, medium: 72, expanded: 80);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: height(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 14,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 26,
              child: Text(
                rank,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface,
                ),
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 18,
              backgroundColor: cs.surfaceContainerHighest,
              child: Icon(Icons.person, size: 18, color: cs.primaryContainer),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              score,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: cs.primaryContainer,
              ),
            ),
            const SizedBox(width: 10),
            Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
