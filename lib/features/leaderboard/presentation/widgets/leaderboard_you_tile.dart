import 'package:flutter/material.dart';

class LeaderboardYouTile extends StatelessWidget {
  const LeaderboardYouTile({
    super.key,
    required this.label,
    required this.name,
    required this.score,
  });

  final String label;
  final String name;
  final String score;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.20),
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
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w800, color: cs.onSurface),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 18,
            backgroundColor: cs.primary.withValues(alpha: 0.16),
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
    );
  }
}
