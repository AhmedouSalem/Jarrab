import 'package:flutter/material.dart';
import '../bloc/leaderboard_bloc.dart';
import '../bloc/leaderboard_event.dart';

class LeaderboardPeriodToggle extends StatelessWidget {
  const LeaderboardPeriodToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final LeaderboardPeriod value;
  final ValueChanged<LeaderboardPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget item(String text, bool selected, VoidCallback onTap) {
      return Expanded(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? cs.primaryContainer : cs.primary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: selected ? cs.onPrimaryContainer : cs.primary.withValues(alpha: 0.35),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          item('Weekly', value == LeaderboardPeriod.weekly, () => onChanged(LeaderboardPeriod.weekly)),
          const SizedBox(width: 6),
          item('All-time', value == LeaderboardPeriod.allTime, () => onChanged(LeaderboardPeriod.allTime)),
        ],
      ),
    );
  }
}
