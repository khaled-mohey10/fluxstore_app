import 'package:flutter/material.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({super.key});

  @override
  State<NotificationSettingPage> createState() =>
      _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  bool _showNotifications = true;
  bool _notificationSounds = true;
  bool _lockScreenNotifications = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSwitchTile(
            context,
            theme: theme,
            title: 'Show notifications',
            subtitle: 'Receive push notifications for new messages',
            value: _showNotifications,
            onChanged: (val) {
              setState(() {
                _showNotifications = val;
              });
            },
          ),
          _buildSwitchTile(
            context,
            theme: theme,
            title: 'Notification sounds',
            subtitle: 'Play sound for new messages',
            value: _notificationSounds,
            onChanged: (val) {
              setState(() {
                _notificationSounds = val;
              });
            },
          ),
          _buildSwitchTile(
            context,
            theme: theme,
            title: 'Lock screen notifications',
            subtitle: 'Allow notification on the lock screen',
            value: _lockScreenNotifications,
            onChanged: (val) {
              setState(() {
                _lockScreenNotifications = val;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required ThemeData theme,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium,
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: theme.primaryColor,
      ),
    );
  }
}