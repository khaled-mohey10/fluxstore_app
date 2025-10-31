import 'package:flutter/material.dart';
import 'package:glamour_app/features/home/presentation/widgets/filter_bottom_sheet.dart';
import 'package:glamour_app/features/home/presentation/widgets/product_card.dart';

class SearchResultsScreen extends StatefulWidget {
  final String categoryTitle;

  const SearchResultsScreen({super.key, required this.categoryTitle});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final List<Map<String, String>> _products = [
    {
      'name': 'Linen Dress',
      'price': '\$52.00',
      'image': 'assets/images/item1.png',
      'oldPrice': '\$90.00',
      'rating': '5.0',
      'reviews': '64',
    },
    {
      'name': 'Filted Waist Dress',
      'price': '\$47.99',
      'image': 'assets/images/item2.png',
      'oldPrice': '\$92.00',
      'rating': '4.0',
      'reviews': '53',
    },
    {
      'name': 'Maxi Dress',
      'price': '\$68.00',
      'image': 'assets/images/item3.png',
      'rating': '3.5',
      'reviews': '46',
    },
    {
      'name': 'Front Tie Mini Dress',
      'price': '\$59.00',
      'image': 'assets/images/photo_1.png',
      'rating': '5.0',
      'reviews': '38',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const FilterBottomSheet(),
              );
            },
            child: Text(
              'Filter',
              style: TextStyle(
                color: theme.textTheme.bodyLarge?.color, 
                fontSize: 16
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.headlineSmall,
                children: [
                  const TextSpan(text: 'Found\n'),
                  TextSpan(
                    text: '${_products.length} Results',
                    style: theme.textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: _products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.55, 
                ),
                itemBuilder: (context, index) {
                  final product = _products[index];
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}