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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu), 
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Text('Glamour'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined), 
            onPressed: () {
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CategoryTabs(),

            const BannerCard(
              imageUrl: 'assets/images/Mask Group.png',
              height: 200,
            ),

            ProductCardList(
              title: 'Feature Products',
              actionText: 'Show all',
              products: _getFeatureProducts(),
              isHorizontal: true,
              onItemTap: (product) {
                Navigator.pushNamed(context, '/product-detail');
              },
            ),

            _buildNewCollectionSection(),

            ProductCardList(
              title: 'Recommended',
              actionText: 'Show all',
              products: _getRecommendedProducts(),
              isHorizontal: true,
              onItemTap: (product) {
                Navigator.pushNamed(context, '/product-detail');
              },
            ),

            _buildTopCollectionSection(context),

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

  Widget _buildTopCollectionSection(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Collection',
                style: theme.textTheme.titleLarge, 
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Show all',
                  style: TextStyle(color: AppColors.text, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/images/cart_2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/images/cart_3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 240,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/cart_4.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 240,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/cart_5.png'),
                      fit: BoxFit.cover,
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

  List<Map<String, String>> _getFeatureProducts() {
    return [
      {
        'name': 'Summer Dress',
        'price': '\$49.99',
        'image': 'assets/images/photo_1.png',
        'oldPrice': '\$79.99',
        'rating': '4.5',
        'reviews': '120',
      },
      {
        'name': 'Casual Shirt',
        'price': '\$29.99',
        'image': 'assets/images/photo_2.png',
        'oldPrice': '\$49.99',
        'rating': '4.2',
        'reviews': '80',
      },
      {
        'name': 'Sportwear Set',
        'price': '\$79.99',
        'image': 'assets/images/photo_3.png',
        'rating': '4.8',
        'reviews': '230',
      },
    ];
  }

  List<Map<String, String>> _getRecommendedProducts() {
    return [
      {
        'name': 'Black Fur Coat',
        'price': '\$29.00',
        'image': 'assets/images/intro1.png',
        'rating': '4.5',
        'reviews': '110',
      },
      {
        'name': 'Black Fur Coat',
        'price': '\$29.00',
        'image': 'assets/images/intro2.png',
        'oldPrice': '\$45.00',
        'rating': '4.7',
        'reviews': '90',
      },
      {
        'name': 'Black Fur Coat',
        'price': '\$29.00',
        'image': 'assets/images/intro3.png',
        'rating': '4.3',
        'reviews': '130',
      },
    ];
  }
}