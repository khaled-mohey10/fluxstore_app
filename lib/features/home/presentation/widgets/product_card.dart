import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final bool isHorizontal; 
  final VoidCallback? onTap;

  final String? oldPrice;
  final double? rating;
  final int? reviewCount;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.isHorizontal = true,
    this.onTap,
    this.oldPrice,
    this.rating,
    this.reviewCount,
  });

  Widget _buildVerticalCard() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
  
    if (isHorizontal) {
      return _buildHorizontalCard();
    } else {
      return _buildVerticalCard();
    }
  }

  Widget _buildHorizontalCard() {
    return Container(
      width: 160, // --- (هذا هو الإصلاح) ---
      margin: const EdgeInsets.only(right: 16), // لإضافة مسافة بين البطاقات
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 180, 
                  width: double.infinity,
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    
                    Row(
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (oldPrice != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            oldPrice!,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
   
                    if (rating != null && reviewCount != null) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              size: 16,
                              color: index < rating! ? Colors.amber : Colors.grey[300],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '($reviewCount)',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                   ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class ProductCardList extends StatelessWidget {
  final String title;
  final String actionText;
  final List<Map<String, String>> products;
  final bool isHorizontal;
  final VoidCallback? onActionTap;
  final Function(Map<String, String> product)? onItemTap;

  const ProductCardList({
    super.key,
    required this.title,
    required this.actionText,
    required this.products,
    this.isHorizontal = true,
    this.onActionTap,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: onActionTap,
                child: Text(
                  actionText,
                  style: TextStyle(color: AppColors.primary, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        if (isHorizontal)
          SizedBox(
            height: 300, 
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  imageUrl: product['image'] ?? '',
                  name: product['name'] ?? '',
                  price: product['price'] ?? '',
                  oldPrice: product['oldPrice'], 
                  rating: double.tryParse(product['rating'] ?? ''), 
                  reviewCount: int.tryParse(product['reviews'] ?? ''), 
                  isHorizontal: true,
                  onTap: () {
                    if (onItemTap != null) {
                      onItemTap!(product);
                    }
                  },
                );
              },
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.6, 
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  imageUrl: product['image'] ?? '',
                  name: product['name'] ?? '',
                  price: product['price'] ?? '',
                  oldPrice: product['oldPrice'],
                  rating: double.tryParse(product['rating'] ?? ''), 
                  reviewCount: int.tryParse(product['reviews'] ?? ''), 
                  isHorizontal: true, 
                  onTap: () {
                    if (onItemTap != null) {
                      onItemTap!(product);
                    }
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}