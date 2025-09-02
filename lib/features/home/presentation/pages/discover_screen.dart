import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';
import 'package:glamour_app/features/home/presentation/widgets/banner_card.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Discover',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط البحث + زر الفلترة
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // مربع البحث مع hint text
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search", // ← الهنت تكست
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // زر الفلترة
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune, color: Colors.grey),
                    onPressed: () {
                      // TODO: add filter action
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // باقي المحتوى
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: const [
                BannerCard(imageUrl: 'assets/images/banar_1.png', height: 130),
                SizedBox(height: 8),
                BannerCard(imageUrl: 'assets/images/banar_2.png', height: 130),
                SizedBox(height: 8),
                BannerCard(imageUrl: 'assets/images/banar_3.png', height: 130),
                SizedBox(height: 8),
                BannerCard(imageUrl: 'assets/images/banar_4.png', height: 130),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
