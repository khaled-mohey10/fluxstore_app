import 'package:flutter/material.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key});

  final List<Map<String, dynamic>> _trackingSteps = const [
    {
      'title': 'Parcel is successfully delivered',
      'date': '15 May 10:20',
      'isCompleted': true,
    },
    {
      'title': 'Parcel is out for delivery',
      'date': '14 May 08:00',
      'isCompleted': true,
    },
    {
      'title': 'Parcel is received at delivery Branch',
      'date': '13 May 17:25',
      'isCompleted': true,
    },
    {
      'title': 'Parcel is in transit',
      'date': '13 May 07:00',
      'isCompleted': true,
    },
    {
      'title': 'Sender has shipped your parcel',
      'date': '12 May 14:25',
      'isCompleted': true,
    },
    {
      'title': 'Sender is preparing to ship your order',
      'date': '12 May 10:01',
      'isCompleted': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivered on 15.05.21',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Tracking Number: IK287368838',
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
            ),
            const SizedBox(height: 32),

            Column(
              children: List.generate(_trackingSteps.length, (index) {
                final step = _trackingSteps[index];
                return _TrackingStepWidget(
                  title: step['title'],
                  subtitle: step['date'],
                  isCompleted: step['isCompleted'],
                  isLastStep: index == _trackingSteps.length - 1,
                );
              }),
            ),
            const SizedBox(height: 32),

            _RateProductCard(theme: theme),
          ],
        ),
      ),
    );
  }
}

class _RateProductCard extends StatelessWidget {
  const _RateProductCard({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Icon(Icons.thumb_up_alt_outlined,
              color: Colors.amber[700], size: 36),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Don't forget to rate",
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rate product to get 5 points for collect.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(
                    5,
                    (index) =>
                        Icon(Icons.star_border, color: Colors.grey[400]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackingStepWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isLastStep;

  const _TrackingStepWidget({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    this.isLastStep = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = theme.primaryColor;
    final inActiveColor = Colors.grey[300];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted ? activeColor : inActiveColor!,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: isCompleted ? activeColor : Colors.transparent,
                ),
              ),
              if (!isLastStep)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      width: 2,
                      color: isCompleted ? activeColor : inActiveColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isCompleted ? Colors.black : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isCompleted ? Colors.black54 : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}