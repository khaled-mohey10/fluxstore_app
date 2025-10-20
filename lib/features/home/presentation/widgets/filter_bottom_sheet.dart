import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _currentRangeValues = const RangeValues(10, 80);
  int _selectedColorIndex = 0;
  int _selectedStarRating = 5;
  String? _selectedCategory = 'Crop Tops';
  final Set<String> _selectedDiscounts = {'50% off', '25% off'};

  final List<Color> _colors = [
    Colors.red,
    Colors.black,
    Colors.grey.shade700,
    Colors.white,
    Colors.brown,
    Colors.pink.shade200,
  ];

  final List<String> _discounts = ['50% off', '40% off', '30% off', '25% off'];

  @override
  Widget build(BuildContext context) {
    final drawerWidth = MediaQuery.of(context).size.width * 0.85;

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),

        SizedBox(
          width: drawerWidth,
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                // جعل الحواف دائرية من اليسار فقط
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // المحتوى القابل للتمرير
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Filter',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.tune),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Price Range
                      _buildSectionTitle('Price'),
                      RangeSlider(
                        values: _currentRangeValues,
                        min: 0,
                        max: 100,
                        divisions: 10,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey.shade300,
                        labels: RangeLabels(
                          '\$${_currentRangeValues.start.round()}',
                          '\$${_currentRangeValues.end.round()}',
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Color Selector
                      _buildSectionTitle('Color'),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _colors.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => setState(() => _selectedColorIndex = index),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: _colors[index],
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: _colors[index] == Colors.white
                                          ? Colors.grey.shade400
                                          : Colors.transparent),
                                ),
                                child: _selectedColorIndex == index
                                    ? const Icon(Icons.check, color: Colors.blue, size: 20)
                                    : null,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(width: 15),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Star Rating
                      _buildSectionTitle('Star Rating'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(5, (index) {
                          final rating = index + 1;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedStarRating = rating),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: _selectedStarRating == rating
                                    ? Colors.black
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    '$rating',
                                    style: TextStyle(
                                        color: _selectedStarRating == rating
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),

                      // Category
                      _buildSectionTitle('Category'),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: <String>['Crop Tops', 'T-Shirts', 'Dresses', 'Jeans']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Discount
                      _buildSectionTitle('Discount'),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: _discounts.map((discount) {
                          return FilterChip(
                            label: Text(discount),
                            selected: _selectedDiscounts.contains(discount),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedDiscounts.add(discount);
                                } else {
                                  _selectedDiscounts.remove(discount);
                                }
                              });
                            },
                            selectedColor: Colors.black,
                            labelStyle: TextStyle(
                              color: _selectedDiscounts.contains(discount)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            backgroundColor: Colors.grey.shade200,
                            checkmarkColor: Colors.white,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Reset Logic
                            setState(() {
                              _currentRangeValues = const RangeValues(10, 80);
                              _selectedColorIndex = 0;
                              _selectedStarRating = 5;
                              _selectedCategory = 'Crop Tops';
                              _selectedDiscounts.clear();
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child:
                              const Text('Reset', style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the filter
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Apply',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}