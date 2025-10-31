import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart'; // (سنحتاجه للـ icon)

class CategoryTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryTab({
    super.key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
                     color: isSelected ? theme.primaryColor : Colors.white,
              border: isSelected ? null : Border.all(color: theme.dividerColor),
            ),
                 child: Icon(
              icon, 
              color: isSelected ? theme.colorScheme.onPrimary : AppColors.text, 
              size: 24
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
                     color: isSelected ? theme.primaryColor : Colors.grey,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key});

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Women', 'icon': Icons.woman},
    {'label': 'Men', 'icon': Icons.man},
    {'label': 'Accessories', 'icon': Icons.watch},
    {'label': 'Beauty', 'icon': Icons.face},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          _categories.length,
          (index) => CategoryTab(
            label: _categories[index]['label'],
            icon: _categories[index]['icon'],
            isSelected: _selectedIndex == index,
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}