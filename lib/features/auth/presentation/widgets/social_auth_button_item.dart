import 'package:flutter/material.dart';

class SocialAuthButtonItem extends StatelessWidget {
  const SocialAuthButtonItem({
    super.key,
    required this.scheme,
    required this.text,
    this.onPressed,
    this.icon,
  });

  final ColorScheme scheme;
  final String text;
  final void Function()? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: scheme.surface,
          side: BorderSide(color: scheme.onSurface.withValues(alpha: 0.10)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        icon: Icon(icon, color: scheme.onSurface),
        label: Text(text, style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }
}
