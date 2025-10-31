import 'package:flutter/material.dart';
import 'package:glamour_app/core/widgets/app_button.dart';

class CartItem {
  final String imageUrl;
  final String name;
  final String size;
  final String color;
  final double price;
  int quantity;
  bool isSelected;

  CartItem({
    required this.imageUrl,
    required this.name,
    required this.size,
    required this.color,
    required this.price,
    this.quantity = 1,
    this.isSelected = true,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<CartItem> _cartItems = [
    CartItem(
      imageUrl: 'assets/images/photo_3.png',
      name: 'Sportwear Set',
      size: 'L',
      color: 'Cream',
      price: 80.00,
    ),
    CartItem(
      imageUrl: 'assets/images/photo_1.png',
      name: 'Turtleneck Sweater',
      size: 'M',
      color: 'White',
      price: 39.99,
    ),
    CartItem(
      imageUrl: 'assets/images/item3.png',
      name: 'Cotton T-shirt',
      size: 'L',
      color: 'Black',
      price: 30.00,
      isSelected: true,
    ),
  ];

  double get _subtotal {
    return _cartItems
        .where((item) => item.isSelected)
        .fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
        automaticallyImplyLeading: false, 
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return _CartItemCard(
                  item: item,
                  onQuantityChanged: (newQuantity) {
                    if (newQuantity > 0) {
                      setState(() {
                        item.quantity = newQuantity;
                      });
                    }
                  },
                  onSelected: (isSelected) {
                    setState(() {
                      item.isSelected = isSelected;
                    });
                  },
                );
              },
            ),
          ),
          _CartSummary(
            subtotal: _subtotal,
            onCheckout: () {
              Navigator.pushNamed(context, '/checkout');
            },
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final ValueChanged<int> onQuantityChanged;
  final ValueChanged<bool> onSelected;

  const _CartItemCard({
    required this.item,
    required this.onQuantityChanged,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              item.imageUrl,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: theme.textTheme.titleMedium,   
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  'Size: ${item.size} | Color: ${item.color}',
                  style: theme.textTheme.bodyMedium,   
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),   
                    ),
                    _QuantityStepper(
                      quantity: item.quantity,
                      onChanged: onQuantityChanged,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Checkbox(
            value: item.isSelected,
            onChanged: (val) => onSelected(val ?? false),
            activeColor: theme.primaryColor,   
            checkColor: theme.colorScheme.onPrimary,
            side: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
        ],
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const _QuantityStepper({required this.quantity, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
         color: Theme.of(context).inputDecorationTheme.fillColor ?? Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 16),
            onPressed: () => onChanged(quantity - 1),
            splashRadius: 20,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          ),
          Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 16),
            onPressed: () => onChanged(quantity + 1),
            splashRadius: 20,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          ),
        ],
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  final double subtotal;
  final VoidCallback onCheckout;

  const _CartSummary({required this.subtotal, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: theme.dividerColor, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSummaryRow(
            'Product price', 
            '\$${subtotal.toStringAsFixed(2)}',
            theme
          ),
          const SizedBox(height: 10),
          _buildSummaryRow('Shipping', 'Freeship', theme),
          Divider(height: 32, thickness: 1, color: theme.dividerColor),
          _buildSummaryRow(
            'Subtotal',
            '\$${subtotal.toStringAsFixed(2)}',
            theme,
            isBold: true,
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'Proceed to checkout',
            onPressed: onCheckout,
            backgroundColor: Colors.black, 
            textColor: Colors.white,      
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount, ThemeData theme, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isBold
              ? theme.textTheme.titleMedium
              : theme.textTheme.bodyMedium,
        ),
        Text(
          amount,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}