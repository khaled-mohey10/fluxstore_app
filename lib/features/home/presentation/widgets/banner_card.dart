import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';

class BannerCard extends StatelessWidget {
  final String imageUrl;
  final double height;

  const BannerCard({super.key, required this.imageUrl, this.height = 200});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.fitWidth,
        ),
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
