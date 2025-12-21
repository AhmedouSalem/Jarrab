import 'package:flutter/material.dart';

class GradientProgressBar extends StatelessWidget {
  const GradientProgressBar({
    super.key,
    required this.value,
    required this.height,
    required this.width,
    required this.backgroundColor,
    required this.gradient,
  });

  final double value;
  final double height;
  final double width;
  final Color backgroundColor;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: width,
        height: height,
        color: backgroundColor,
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: clamped,
          child: Container(decoration: BoxDecoration(gradient: gradient)),
        ),
      ),
    );
  }
}
