import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';
import 'package:glamour_app/core/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glamour_app/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:glamour_app/features/home/presentation/widgets/category_tab.dart';
import 'package:glamour_app/features/home/presentation/widgets/product_card.dart';
import 'package:glamour_app/features/home/presentation/widgets/banner_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const SearchPage(),
    const DiscoverPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'GemStore',
        showMenu: true,
        showNotification: true,
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
          const Text(
            'New Collection',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Show all',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // First Card
          Container(
            height: 200,
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
              height: 280,
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
                  height: 280,
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
                  height: 280,
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
        'image': 'assets/images/intro1.png',
      },
      {
        'name': 'Casual Shirt',
        'price': '\$29.99',
        'image': 'assets/images/intro2.png',
      },
      {
        'name': 'Denim Jacket',
        'price': '\$79.99',
        'image': 'assets/images/intro3.png',
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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'User';
    final userEmail = user?.email ?? 'No email';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              userEmail,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Profile Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.white),
                    title: const Text(
                      'Name',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      userName,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  ListTile(
                    leading: const Icon(Icons.email, color: Colors.white),
                    title: const Text(
                      'Email',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      userEmail,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final authService = FirebaseAuthService();
    await authService.signOut(context);

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'User';
    final userEmail = user?.email ?? 'No email';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userEmail,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Settings Options
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Logout Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () => _handleLogout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Search Page\nComing Soon',
          style: TextStyle(color: Colors.white, fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Discover'),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Discover Page\nComing Soon',
          style: TextStyle(color: Colors.white, fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Cart Page\nComing Soon',
          style: TextStyle(color: Colors.white, fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
