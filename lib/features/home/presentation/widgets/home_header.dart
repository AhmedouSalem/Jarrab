import 'package:flutter/material.dart';
import 'package:jarrab/shared/widgets/app_logo.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.title,
    required this.onNotificationTap,
  });

  final String title;
  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppLogo(width: 52, height: 52),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        IconButton(
          tooltip:
              'notifications', // tooltip pas critique, tu peux i18n aussi si tu veux
          onPressed: onNotificationTap,
          icon: const Icon(Icons.notifications_none),
        ),
      ],
    );
  }
}
