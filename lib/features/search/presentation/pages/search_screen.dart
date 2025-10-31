import 'package:flutter/material.dart';
import 'package:glamour_app/features/home/presentation/widgets/filter_bottom_sheet.dart';
import 'package:glamour_app/features/search/presentation/pages/search_results_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = ['Sunglasses', 'Sweater', 'Hoodie'];
  final List<Map<String, String>> _popularItems = [
    {
      'name': 'Lihua Tunic White',
      'price': '\$53.00',
      'image': 'assets/images/item1.png',
    },
    {
      'name': 'Skirt Dress',
      'price': '\$34.00',
      'image': 'assets/images/item2.png',
    },
    {
      'name': 'Another Item',
      'price': '\$45.00',
      'image': 'assets/images/item3.png',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), 
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search dresses, shoes, etc",
            hintStyle: TextStyle(color: Colors.grey.shade500),
            border: InputBorder.none,
            enabledBorder: InputBorder.none, 
            focusedBorder: InputBorder.none, 
            filled: false,
          ),
          style: theme.textTheme.bodyLarge,
          onSubmitted: (query) {
            if (query.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SearchResultsScreen(categoryTitle: query),
                ),
              );
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.grey),
            onPressed: () {
              _searchController.clear();
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.grey),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const FilterBottomSheet(),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Recent Searches', theme),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _recentSearches.map((term) => _buildChip(term, theme)).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Popular this week', theme),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const SearchResultsScreen(categoryTitle: "Popular Items"),
                    ),
                  );
                },
                child: Text('Show all', style: theme.textTheme.bodyMedium),
              )
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _popularItems.length,
              itemBuilder: (context, index) {
                final item = _popularItems[index];
                return Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(item['image'] ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['name'] ?? '',
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['price'] ?? '',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor, 
                        ),
                      ),
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

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: theme.textTheme.titleMedium, 
      ),
    );
  }

  Widget _buildChip(String label, ThemeData theme) {
    return Chip(
      label: Text(label, style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
      backgroundColor: theme.inputDecorationTheme.fillColor ?? Colors.grey[100],
      deleteIcon: const Icon(Icons.close, size: 16, color: Colors.black54),
      onDeleted: () {
        setState(() {
          _recentSearches.remove(label);
        });
      },
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[300]!)
      ),
    );
  }
}