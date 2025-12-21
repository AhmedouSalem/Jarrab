import 'package:flutter/material.dart';
import 'profile_section_card.dart';

class ProfileAchievementsCard extends StatelessWidget {
  const ProfileAchievementsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget chip(IconData icon, String label) {
      return Expanded(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {}, // UI-only
            borderRadius: BorderRadius.circular(14),
            child: Container(
              height: 88,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: cs.primaryContainer),
                  const SizedBox(height: 10),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: cs.onSurface,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return ProfileSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievements',
            style: TextStyle(
              color: cs.onSurface,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              chip(Icons.workspace_premium_outlined, 'Quiz Master'),
              const SizedBox(width: 12),
              chip(Icons.emoji_events_outlined, 'Perfect Score'),
              const SizedBox(width: 12),
              chip(Icons.schedule, 'Daily Streak'),
            ],
          ),
        ],
      ),
    );
  }
}
