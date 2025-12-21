import 'package:flutter/material.dart';
import 'profile_section_card.dart';

class ProfileProgressCard extends StatelessWidget {
  const ProfileProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ProfileSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress to Next Level',
            style: TextStyle(
              color: cs.onSurface,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text('Level 5', style: TextStyle(color: cs.onSurfaceVariant)),
              const Spacer(),
              Text('Level 6', style: TextStyle(color: cs.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 10),

          // Progress bar (75%)
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 8,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(color: cs.primary.withValues(alpha: 0.22)),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.75,
                    child: Container(color: cs.primaryContainer),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),
          Center(
            child: Text(
              '75% towards Level 6!',
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }
}
