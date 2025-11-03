import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // هذا الزر سيفتح القائمة الجانبية
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Text('Setting'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSettingItem(
            context,
            icon: Icons.language_outlined,
            title: 'Language',
            onTap: () {
              // TODO: Implement Language Page
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.notifications_none_outlined,
            title: 'Notification',
            onTap: () {
              // سيتم ربطها في الخطوة القادمة
              Navigator.pushNamed(context, '/notification-settings');
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.list_alt_outlined,
            title: 'Terms of Use',
            onTap: () {
              // TODO: Implement Terms Page
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.info_outline,
            title: 'Privacy Policy',
            onTap: () {
              // TODO: Implement Privacy Policy Page
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.send_outlined, 
            title: 'Chat support',
            onTap: () {
              // سيتم ربطها لاحقاً
              Navigator.pushNamed(context, '/chat-support');
            },
          ),
        ],
      ),
    );
  }

  // ويدجت مساعد لإنشاء كل سطر
  Widget _buildSettingItem(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.textTheme.bodyLarge?.color, size: 24),
      title: Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}