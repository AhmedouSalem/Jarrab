import 'package:flutter/material.dart';

class QuizHeader extends StatelessWidget {
  const QuizHeader({super.key, required this.title, required this.onBack});
  final String title;
  final Function()? onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBack),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
