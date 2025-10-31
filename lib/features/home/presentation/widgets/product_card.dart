import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final bool isHorizontal; // هذا الاسم مربك، لكننا سنلتزم به
  final VoidCallback? onTap;

  // --- 🔽 الإضافات الجديدة 🔽 ---
  final String? oldPrice;
  final double? rating;
  final int? reviewCount;
  // --- 🔼 الإضافات الجديدة 🔼 ---

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.isHorizontal = true,
    this.onTap,
    // --- 🔽 الإضافات الجديدة 🔽 ---
    this.oldPrice,
    this.rating,
    this.reviewCount,
    // --- 🔼 الإضافات الجديدة 🔼 ---
  });

  // البطاقة ذات الخلفية الداكنة (القديمة)
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
                  // يمكن إضافة السعر القديم والتقييم هنا أيضًا إذا أردت
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
    // isHorizontal: true = البطاقة البيضاء (لصفحة البحث والصفحة الرئيسية)
    // isHorizontal: false = البطاقة الداكنة (غير مستخدمة حاليًا في البحث)
    if (isHorizontal) {
      return _buildHorizontalCard();
    } else {
      return _buildVerticalCard();
    }
  }

  // البطاقة ذات الخلفية البيضاء (الجديدة المطابقة لـ found results.pdf)
  Widget _buildHorizontalCard() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // العرض يتم تحديده بواسطة الـ GridView
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
            // صورة المنتج
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                // تحديد ارتفاع نسبي للصورة لجعل البطاقات متجاوبة
                height: 180, 
                width: double.infinity,
              ),
            ),
            
            // التفاصيل
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
                  
                  // --- 🔽 التعديل هنا (إضافة الأسعار) 🔽 ---
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
                  // --- 🔼 التعديل هنا 🔼 ---

                  // --- 🔽 التعديل هنا (إضافة التقييم) 🔽 ---
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
                  // --- 🔼 التعديل هنا 🔼 ---
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ... (ProductCardList سيبقى كما هو من المرة السابقة) ...
// (الكود الذي أضفناه في الخطوة 6 سيعمل مباشرة مع هذا التعديل)

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
            height: 300, // الارتفاع هنا مضبوط للبطاقة الجديدة
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
                  oldPrice: product['oldPrice'], // تمرير البيانات
                  rating: double.tryParse(product['rating'] ?? ''), // تمرير البيانات
                  reviewCount: int.tryParse(product['reviews'] ?? ''), // تمرير البيانات
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
                childAspectRatio: 0.6, // نسبة العرض للارتفاع للبطاقة في الشبكة
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  imageUrl: product['image'] ?? '',
                  name: product['name'] ?? '',
                  price: product['price'] ?? '',
                  oldPrice: product['oldPrice'], // تمرير البيانات
                  rating: double.tryParse(product['rating'] ?? ''), // تمرير البيانات
                  reviewCount: int.tryParse(product['reviews'] ?? ''), // تمرير البيانات
                  isHorizontal: true, // !! استخدام البطاقة البيضاء !!
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