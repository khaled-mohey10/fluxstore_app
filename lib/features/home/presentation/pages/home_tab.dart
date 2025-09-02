import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';
import 'package:glamour_app/features/home/presentation/widgets/category_tab.dart';
import 'package:glamour_app/features/home/presentation/widgets/product_card.dart';
import 'package:glamour_app/features/home/presentation/widgets/banner_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Text(
          'GemStore',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // TODO: Implement notification functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Tabs
            const CategoryTabs(),

            // Main Banner
            const BannerCard(
              imageUrl: 'assets/images/Mask Group.png', // Using existing asset
              height: 200,
            ),

            // Feature Products Section
            ProductCardList(
              title: 'Feature Products',
              actionText: 'Show all',
              products: _getFeatureProducts(),
              isHorizontal: true,
            ),

            // New Collection Section
            _buildNewCollectionSection(),

            // Recommended Section
            ProductCardList(
              title: 'Recommended',
              actionText: 'Show all',
              products: _getRecommendedProducts(),
              isHorizontal: true,
            ),

            // Top Collection Section
            _buildTopCollectionSection(),

            // Quick Categories Section
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNewCollectionSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/cart_1.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCollectionSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Collection',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Show all',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // First Card
          Container(
            height: 180, // Reduced from 200
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/images/cart_2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),

          // Second Card
          Center(
            child: Container(
              height: 240, // Reduced from 280
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/cart_3.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Row with Two Cards
          Row(
            children: [
              // Left Card
              Expanded(
                child: Container(
                  height: 240, // Reduced from 280
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/cart_4.png'),
                    ),
                  ),
                ),
              ),

              // Right Card
              Expanded(
                child: Container(
                  height: 240, // Reduced from 280
                  margin: const EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/cart_5.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCategoryCard(String title, IconData icon) {
    return Container(
      width: 140,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getFeatureProducts() {
    return [
      {
        'name': 'Summer Dress',
        'price': '\$49.99',
        'image': 'assets/images/photo_1.png',
      },
      {
        'name': 'Casual Shirt',
        'price': '\$29.99',
        'image': 'assets/images/photo_2.png',
      },
      {
        'name': 'Denim Jacket',
        'price': '\$79.99',
        'image': 'assets/images/photo_3.png',
      },
      {
        'name': 'Sneakers',
        'price': '\$89.99',
        'image': 'assets/images/welcome_hero.png',
      },
    ];
  }

  List<Map<String, String>> _getRecommendedProducts() {
    return [
      {
        'name': 'White fashion hoodie',
        'price': '\$29.00',
        'image': 'assets/images/intro1.png',
      },
      {
        'name': 'White fashion hoodie',
        'price': '\$29.00',
        'image': 'assets/images/intro2.png',
      },
      {
        'name': 'White fashion hoodie',
        'price': '\$29.00',
        'image': 'assets/images/intro3.png',
      },
    ];
  }

  List<Map<String, String>> _getTopCollectionProducts() {
    return [
      {
        'name': 'For Slim & Beauty',
        'price': '\$69.99',
        'image': 'assets/images/intro1.png',
      },
      {
        'name': 'Most sexy & fabulous design',
        'price': '\$99.99',
        'image': 'assets/images/intro2.png',
      },
      {
        'name': 'Trending Now',
        'price': '\$54.99',
        'image': 'assets/images/intro3.png',
      },
      {
        'name': 'Classic Style',
        'price': '\$74.99',
        'image': 'assets/images/welcome_hero.png',
      },
    ];
  }
}
