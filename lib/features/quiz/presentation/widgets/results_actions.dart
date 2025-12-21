import 'package:flutter/material.dart';

class ResultsActions extends StatelessWidget {
  const ResultsActions({
    super.key,
    required this.primaryText,
    required this.secondaryText,
    required this.onRetry,
    required this.onShare,
  });

  final String primaryText;
  final String secondaryText;
  final VoidCallback onRetry;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 54,
          child: FilledButton(onPressed: onRetry, child: Text(primaryText)),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: OutlinedButton(onPressed: onShare, child: Text(secondaryText)),
        ),
      ],
    );
  }
}
