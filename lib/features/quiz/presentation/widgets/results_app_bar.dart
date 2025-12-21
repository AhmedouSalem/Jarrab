import 'package:flutter/material.dart';

class ResultsAppBar extends StatelessWidget {
  const ResultsAppBar({
    super.key,
    required this.title,
    required this.onHomeTap,
    required this.onShareTap,
  });

  final String title;
  final VoidCallback onHomeTap;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          IconButton(
            onPressed: onHomeTap,
            icon: const Icon(Icons.home_outlined),
          ),
          Expanded(
            child: Center(
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          IconButton(
            onPressed: onShareTap,
            icon: const Icon(Icons.ios_share_outlined),
          ),
        ],
      ),
    );
  }
}
