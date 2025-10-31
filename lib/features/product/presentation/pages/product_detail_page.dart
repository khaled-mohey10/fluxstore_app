import 'package:flutter/material.dart';
import 'package:glamour_app/core/widgets/app_button.dart';
import 'package:glamour_app/features/home/presentation/widgets/product_card.dart';
import 'dart:ui'; 

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 2; 
  int _currentImagePage = 0;

  final List<Color> _colors = [
    const Color(0xFFE0C0A9), 
    Colors.black,
    const Color(0xFFE65C5C), 
  ];

  final List<String> _sizes = ['S', 'M', 'L'];
  
  final List<Map<String, String>> _similarProducts = [
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
        'image': 'assets/images/intro1.png',
      },
  ];

  final List<String> _productImages = [
    'assets/images/photo_3.png',
    'assets/images/photo_3.png',
    'assets/images/photo_3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildAddToCartButton(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSlider(),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildRating(),
                  const SizedBox(height: 24),
                  _buildColorSelector(),
                  const SizedBox(height: 24),
                  _buildSizeSelector(),
                  const SizedBox(height: 24),
                  _ExpandableSection(
                    title: 'Description',
                    child: Text(
                      'Sportwear is no longer under culture, it is no longer plaid or coloblocked together as it once was. Sport is fashion today. The top is oversized in fit and style, may need to size down.',
                      style: TextStyle(color: Colors.grey[700], fontSize: 14, height: 1.5),
                    ),
                  ),
                  _ExpandableSection(
                    title: 'Reviews',
                    child: _buildReviewsSection(),
                  ),
                  _ExpandableSection(
                    title: 'Similar Product',
                    child: _buildSimilarProducts(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildImageSlider() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      color: Colors.grey[100],
      child: Stack(
        children: [
          PageView.builder(
            itemCount: _productImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentImagePage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                _productImages[index],
                fit: BoxFit.cover,
              );
            },
          ),
          
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleButton(Icons.arrow_back_ios_new, () => Navigator.pop(context)),
                _buildCircleButton(Icons.favorite_border, () { /* TODO: Add to favorites */ }),
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_productImages.length, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImagePage == index ? Colors.black : Colors.grey[400],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
        color: Colors.black,
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sportwear Set',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          '\$ 80.00',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        ...List.generate(5, (index) => Icon(
          Icons.star,
          color: index == 4 ? Colors.grey[300] : Colors.amber,
          size: 20,
        )),
        const SizedBox(width: 8),
        const Text(
          '(83)', 
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(
          children: List.generate(_colors.length, (index) {
            bool isSelected = _selectedColorIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedColorIndex = index),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelected ? Border.all(color: Colors.black, width: 1.5) : null,
                ),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _colors[index],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Size', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(
          children: List.generate(_sizes.length, (index) {
            bool isSelected = _selectedSizeIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedSizeIndex = index),
              child: Container(
                width: 45,
                height: 45,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    _sizes[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              '4.9',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('OUT OF 5', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Row(
                  children: List.generate(5, (i) => const Icon(Icons.star, color: Colors.amber, size: 16)),
                ),
              ],
            ),
            const Spacer(),
            const Text('83 ratings', style: TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 16),
        _ReviewCard(
          name: 'Jennifer Rose',
          time: '5m ago',
          review: 'I love it. Awesome customer service!! Helped me out with adding an additional item to my order. Thanks again!',
        ),
        _ReviewCard(
          name: 'Kelly Rihana',
          time: '9m ago',
          review: 'I\'m very happy with order, It was delivered on and good quality. Recommended!',
        ),
        TextButton(
          onPressed: () { /* TODO: Show all reviews */ },
          child: const Text(
            'See all 47 Reviews', 
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)
          ),
        ),
      ],
    );
  }

  Widget _ReviewCard({required String name, required String time, required String review}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                // TODO: Add user image if available
                child: const Icon(Icons.person, color: Colors.white), 
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: List.generate(5, (i) => const Icon(Icons.star, color: Colors.amber, size: 14)),
                  ),
                ],
              ),
              const Spacer(),
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(review, style: TextStyle(color: Colors.grey[800], height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildSimilarProducts() {
    return SizedBox(
      height: 280, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _similarProducts.length,
        itemBuilder: (context, index) {
          final product = _similarProducts[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ProductCard(
              imageUrl: product['image'] ?? '',
              name: product['name'] ?? '',
              price: product['price'] ?? '',
              isHorizontal: true, 
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildAddToCartButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: AppButton(
        text: 'Add To Cart',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added to cart! (Mock)')),
          );
        },
        backgroundColor: Colors.black,
        textColor: Colors.white,
        borderRadius: 30,
      ),
    );
  }
}

class _ExpandableSection extends StatefulWidget {
  final String title;
  final Widget child;
  final bool isInitiallyExpanded;

  const _ExpandableSection({
    required this.title,
    required this.child,
    this.isInitiallyExpanded = false,
  });

  @override
  State<_ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<_ExpandableSection> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isInitiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 1.5),
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: widget.child,
          ),
      ],
    );
  }
}