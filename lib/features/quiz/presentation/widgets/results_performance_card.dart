import 'package:flutter/material.dart';

class ResultsPerformanceCard extends StatelessWidget {
  const ResultsPerformanceCard({
    super.key,
    required this.title,
    required this.correctLabel,
    required this.incorrectLabel,
    required this.correct,
    required this.incorrect,
  });

  final String title;
  final String correctLabel;
  final String incorrectLabel;
  final int correct;
  final int incorrect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.08),
            blurRadius: 18,
            spreadRadius: 2,
            offset: const Offset(0, 0), // ombre autour
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),

          _RowItem(
            icon: Icons.check_circle_outline,
            iconColor: Colors.green,
            label: correctLabel,
            value: correct.toString(),
          ),
          const SizedBox(height: 10),
          _RowItem(
            icon: Icons.cancel_outlined,
            iconColor: Colors.red,
            label: incorrectLabel,
            value: incorrect.toString(),
          ),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 10),
        Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
