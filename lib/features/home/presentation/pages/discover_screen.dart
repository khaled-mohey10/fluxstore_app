import 'package:flutter/material.dart';
import 'package:glamour_app/features/home/presentation/widgets/filter_bottom_sheet.dart';
import 'package:glamour_app/features/search/presentation/pages/search_results_screen.dart';
import 'package:glamour_app/features/search/presentation/pages/search_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int? _expandedIndex;

  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'CLOTHING',
      'image': 'assets/images/banar_1.png',
      'subCategories': [
        {'name': 'Jacket', 'itemCount': '127 items'},
        {'name': 'Shirts', 'itemCount': '27 items'},
        {'name': 'Dresses', 'itemCount': '45 items'},
        {'name': 'Trousers', 'itemCount': '16 items'},
        {'name': 'Jeans', 'itemCount': '21 items'},
        {'name': 'Pants', 'itemCount': '7 items'},
      ],
    },
    {
      'title': 'ACCESSORIES',
      'image': 'assets/images/banar_2.png',
      'subCategories': [
        {'name': 'Bags', 'itemCount': '30 items'},
        {'name': 'Watches', 'itemCount': '18 items'},
        {'name': 'Jewelry', 'itemCount': '50 items'},
      ],
    },
    {
      'title': 'SHOES',
      'image': 'assets/images/banar_3.png',
      'subCategories': [
        {'name': 'Heels', 'itemCount': '25 items'},
        {'name': 'Sneakers', 'itemCount': '35 items'},
        {'name': 'Boots', 'itemCount': '15 items'},
      ],
    },
    {
      'title': 'COLLECTION',
      'image': 'assets/images/banar_4.png',
      'subCategories': [
        {'name': 'Summer 2025', 'itemCount': '40 items'},
        {'name': 'Winter 2025', 'itemCount': '22 items'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  child: Row(
    children: [
            Expanded(
              child: GestureDetector( 
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchScreen()),
                  );
                },
                child: AbsorbPointer( 
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
          const SizedBox(height: 10),
Expanded(
  child: ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    itemCount: _categories.length,
    itemBuilder: (context, index) {
      final category = _categories[index];
      final isExpanded = _expandedIndex == index;

      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(  
          children: [
            GestureDetector( 
               onTap: () {
                 setState(() {
                   if (isExpanded) {
                     _expandedIndex = null;
                   } else {
                     _expandedIndex = index;
                   }
                 });
               },
              child: CategoryBanner(
                imageUrl: category['image'],
              ),
            ),
            if (isExpanded)
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    )),
                child: Column(
                  children: [
                    for (var subCategory in category['subCategories'])
                      Column(
                        children: [
                          ListTile(
                            title: Text(subCategory['name']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  subCategory['itemCount'],
                                  style:
                                      const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward_ios,
                                    size: 16, color: Colors.grey),
                              ],
                            ),
                            onTap: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => SearchResultsScreen(categoryTitle: subCategory['name']),
                                 ),
                               );
                            },
                          ),
                          if (subCategory != category['subCategories'].last) 
                           const Divider(height: 1, indent: 16, endIndent: 16), 
                        ],
                      ),
                  ],
                ),
              )
          ],
        ),
      );
    },
  ),
),
        ],
      ),
    );
  }
}

class CategoryBanner extends StatelessWidget {
  final String imageUrl;

  const CategoryBanner({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}