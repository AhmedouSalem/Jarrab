import 'package:flutter/material.dart';
import 'profile_section_card.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ProfileSectionCard(
      child: Column(
        children: [
          const SizedBox(height: 6),

          // Avatar + online dot
          Stack(
            children: [
              CircleAvatar(
                radius: 42,
                backgroundColor: cs.surfaceContainerHighest,
                child: Icon(Icons.person, size: 40, color: cs.primaryContainer),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: const Color(0xFF35C759),
                    shape: BoxShape.circle,
                    border: Border.all(color: cs.surface, width: 3),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            'Alice Johnson',
            style: TextStyle(
              color: cs.onSurface,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Lifelong learner passionate about science\nand history. Always looking for new\nchallenges and quizzes!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: cs.onSurfaceVariant,
              height: 1.25,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            height: 44,
            width: double.infinity,
            child: FilledButton(
              onPressed: () {}, // UI-only
              style: FilledButton.styleFrom(
                backgroundColor: cs.primaryContainer,
                foregroundColor: cs.onPrimaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.w700),
              ),
              child: const Text('Edit Profile'),
            ),
          ),
        ],
      ),
    );
  }
}
