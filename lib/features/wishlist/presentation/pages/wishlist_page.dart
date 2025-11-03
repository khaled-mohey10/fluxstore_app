import 'package:flutter/material.dart';
import 'package:glamour_app/features/home/presentation/widgets/product_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> _allItems = [
    {
      'name': 'Front Tie Mini Dress',
      'price': '\$ 59.00',
      'image': 'assets/images/photo_1.png',
      'rating': '4.0',
      'reviews': '38',
    },
    {
      'name': 'Linen Dress',
      'price': '\$ 52.00',
      'image': 'assets/images/item1.png',
      'oldPrice': '\$90.00',
      'rating': '5.0',
      'reviews': '64',
    },
    {
      'name': 'Ohara Dress',
      'price': '\$ 85.00',
      'image': 'assets/images/item2.png',
      'rating': '4.0',
      'reviews': '50',
    },
    {
      'name': 'Tie Back Mini Dress',
      'price': '\$ 67.00',
      'image': 'assets/images/item3.png',
      'rating': '3.5',
      'reviews': '39',
    },
  ];

  final List<Map<String, dynamic>> _boards = [
    {
      'title': 'Going out outfits',
      'count': 36,
      'images': [
        'assets/images/photo_3.png',
        'assets/images/photo_1.png',
        'assets/images/item3.png',
        'assets/images/item1.png',
      ]
    },
    {
      'title': 'Office Fashion',
      'count': 20,
      'images': [
        'assets/images/item2.png',
        'assets/images/photo_2.png',
        'assets/images/cart_5.png',
        'assets/images/cart_4.png',
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: theme.primaryColor,
          labelColor: theme.primaryColor,
          unselectedLabelColor: Colors.grey[600],
          tabs: const [
            Tab(text: 'All items'),
            Tab(text: 'Boards'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllItemsGrid(context),
          _buildBoardsList(context),
        ],
      ),
    );
  }

  Widget _buildAllItemsGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _allItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.55,
      ),
      itemBuilder: (context, index) {
        final product = _allItems[index];
        return ProductCard(
          imageUrl: product['image'] ?? '',
          name: product['name'] ?? '',
          price: product['price'] ?? '',
          oldPrice: product['oldPrice'],
          rating: double.tryParse(product['rating'] ?? '0.0'),
          reviewCount: int.tryParse(product['reviews'] ?? '0'),
          isHorizontal: true,
          onTap: () {
            Navigator.pushNamed(context, '/product-detail');
          },
        );
      },
    );
  }

  Widget _buildBoardsList(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _boards.length,
        itemBuilder: (context, index) {
          final board = _boards[index];
          return _buildBoardCard(context, board);
        });
  }

  Widget _buildBoardCard(BuildContext context, Map<String, dynamic> board) {
    final theme = Theme.of(context);
    final List<String> images = board['images'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    child: Image.asset(images[0], fit: BoxFit.cover, height: 200),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.only(topRight: Radius.circular(8)),
                          child: Image.asset(images[1],
                              fit: BoxFit.cover, width: double.infinity),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(8)),
                              child: Image.asset(images[2],
                                  fit: BoxFit.cover, width: double.infinity),
                            ),
                            if (images.length > 3)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(8)),
                                ),
                                child: Center(
                                    child: Text(
                                  "+${images.length - 3}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(board['title'],
                      style: theme.textTheme.headlineSmall?.copyWith(fontSize: 22)),
                  Text('${board['count']} items',
                      style: theme.textTheme.bodyMedium),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
            ],
          )
        ],
      ),
    );
  }
}