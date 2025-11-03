import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  final List<Map<String, String>> _notifications = const [
    {
      'title': 'Good morning! Get 20% Voucher',
      'subtitle': 'Summer sale up to 20% off. Limited voucher. Get now!! 😄',
    },
    {
      'title': 'Special offer just for you',
      'subtitle': 'New Autumn Collection 30% off',
    },
    {
      'title': 'Holiday sale 50%',
      'subtitle': 'Tap here to get 50% voucher.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _buildNotificationCard(
            context: context,
            theme: theme,
            title: notification['title']!,
            subtitle: notification['subtitle']!,
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard({
    required BuildContext context,
    required ThemeData theme,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200.withOpacity(0.7),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}