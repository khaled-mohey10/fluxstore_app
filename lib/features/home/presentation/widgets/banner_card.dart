import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';

class BannerCard extends StatelessWidget {
  final String imageUrl;
  final double height;

  const BannerCard({super.key, required this.imageUrl, this.height = 200});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover, 
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.15), 
            ),
          ),
          Positioned(
  top: 20,
  right: 20,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, 
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Autumn \nCollection',
        style: theme.textTheme.headlineSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      Text(
        '2025',
        style: theme.textTheme.headlineMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
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

class CircularBannerCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double size;

  const CircularBannerCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}