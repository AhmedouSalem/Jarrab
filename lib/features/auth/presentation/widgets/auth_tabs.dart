import 'package:flutter/material.dart';
import 'package:jarrab/l10n/app_localizations.dart';

class AuthTabs extends StatelessWidget {
  const AuthTabs({
    super.key,
    required this.isLogin,
    required this.onTapLogin,
    required this.onTapSignUp,
  });

  final bool isLogin;
  final VoidCallback onTapLogin;
  final VoidCallback onTapSignUp;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabPill(
              text: l10n.login,
              selected: isLogin,
              selectedColor: scheme.primaryContainer,
              onTap: onTapLogin,
            ),
          ),
          Expanded(
            child: _TabPill(
              text: l10n.signUp,
              selected: !isLogin,
              selectedColor: scheme.primaryContainer,
              onTap: onTapSignUp,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.text,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? selectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: selected ? scheme.surface : scheme.onSurface,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
