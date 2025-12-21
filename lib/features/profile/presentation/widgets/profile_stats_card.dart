import 'package:flutter/material.dart';
import 'profile_section_card.dart';

class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget stat(IconData icon, String value, String label) {
      return Expanded(
        child: Column(
          children: [
            Icon(icon, color: cs.primaryContainer),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                color: cs.primaryContainer,
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: cs.onSurfaceVariant,
                fontSize: 11.5,
                height: 1.1,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      );
    }

    return ProfileSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Stats',
            style: TextStyle(
              color: cs.onSurface,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Divider(height: 1, color: cs.outlineVariant.withValues(alpha: 0.45)),
          const SizedBox(height: 14),
          Row(
            children: [
              stat(Icons.flash_on_outlined, '124', 'QUIZZES\nTAKEN'),
              stat(Icons.check_circle_outline, '88%', 'ACCURACY'),
              stat(Icons.access_time, '15 Days', 'STREAK'),
            ],
          ),
        ],
      ),
    );
  }
}
