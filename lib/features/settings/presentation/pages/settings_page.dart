import 'package:flutter/material.dart';

import '../widgets/settings_section_card.dart';
import '../widgets/settings_tile.dart';
import '../widgets/settings_switch_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: cs.surfaceContainerLow,
        body: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
              child: Center(
                child: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
              ),
            ),
            const Divider(height: 1),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SettingsSectionCard(
                      title: 'Account',
                      children: const [
                        SettingsTile(
                          leading: Icons.person_outline,
                          title: 'Edit Profile',
                          subtitle: 'Update your personal info',
                          showChevron: true,
                        ),
                        SettingsTile(
                          leading: Icons.lock_outline,
                          title: 'Change Password',
                          subtitle: 'Update your password',
                          showChevron: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    SettingsSectionCard(
                      title: 'Preferences',
                      children: const [
                        SettingsTile(
                          leading: Icons.language_outlined,
                          title: 'Language',
                          subtitle: 'English',
                          showChevron: true,
                        ),
                        SettingsTile(
                          leading: Icons.dark_mode_outlined,
                          title: 'Theme',
                          subtitle: 'System',
                          showChevron: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    SettingsSectionCard(
                      title: 'Notifications',
                      children: const [
                        SettingsSwitchTile(
                          leading: Icons.notifications_outlined,
                          title: 'Push Notifications',
                          subtitle: 'Get reminders and updates',
                          value: true,
                        ),
                        SettingsSwitchTile(
                          leading: Icons.volume_up_outlined,
                          title: 'Sound Effects',
                          subtitle: 'Play sounds on win/lose',
                          value: true,
                        ),
                        SettingsSwitchTile(
                          leading: Icons.vibration_outlined,
                          title: 'Haptics',
                          subtitle: 'Vibration feedback',
                          value: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    SettingsSectionCard(
                      title: 'Support',
                      children: const [
                        SettingsTile(
                          leading: Icons.help_outline,
                          title: 'Help Center',
                          subtitle: 'FAQ and guides',
                          showChevron: true,
                        ),
                        SettingsTile(
                          leading: Icons.privacy_tip_outlined,
                          title: 'Privacy Policy',
                          subtitle: 'Read how we handle your data',
                          showChevron: true,
                        ),
                        SettingsTile(
                          leading: Icons.description_outlined,
                          title: 'Terms of Service',
                          subtitle: 'Rules and usage',
                          showChevron: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Danger zone / sign out
                    SettingsSectionCard(
                      title: 'Session',
                      children: const [
                        SettingsTile(
                          leading: Icons.logout,
                          title: 'Sign out',
                          subtitle: 'Disconnect from this device',
                          isDestructive: true,
                          showChevron: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
