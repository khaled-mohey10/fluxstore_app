import 'package:flutter/material.dart';
import 'package:glamour_app/core/widgets/app_button.dart'; // هنحتاجه للأزرار

class OrderInfoPage extends StatefulWidget {
  const OrderInfoPage({super.key});

  @override
  State<OrderInfoPage> createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  // متغيرات عشان نخزن فيها البيانات اللي هتجيلنا
  late String orderNumber;
  late String status;
  late Map<String, dynamic> orderData;
  bool isDelivered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // استقبال البيانات المرسلة من صفحة "My Orders"
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      orderData = arguments;
      orderNumber = orderData['number'] ?? 'N/A';
      status = orderData['status'] ?? 'N/A';
      isDelivered = status.toUpperCase() == 'DELIVERED';
    } else {
      // Fallback in case no arguments are passed
      orderData = {};
      orderNumber = 'Error';
      status = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order #$orderNumber'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Order Status Banner
            _buildStatusBanner(theme),
            const SizedBox(height: 24),

            // 2. Order Details
            _buildOrderDetailsSection(theme),
            const SizedBox(height: 24),

            // 3. Product List
            _buildProductListSection(theme),
            const SizedBox(height: 24),

            // 4. Order Summary
            _buildOrderSummarySection(theme),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  // --- Widgets ---

  Widget _buildStatusBanner(ThemeData theme) {
    // بناءً على الصور (order info-1.png, order info-2.png)
    String title;
    String subtitle;
    IconData icon;

    if (isDelivered) {
      title = 'Your order is delivered';
      subtitle = 'Rate product to get 5 points for collect.';
      icon = Icons.delivery_dining; // أو أي أيقونة مناسبة
    } else {
      title = 'Your order is on the way';
      subtitle = 'Click here to track your order';
      icon = Icons.local_shipping;
    }

    return GestureDetector(
      onTap: () {
        if (!isDelivered) {
          print('Navigate to Track Order');
        } else {
          print('Navigate to Rate Product');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: Colors.white)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white70)),
              ],
            ),
            Icon(icon, color: Colors.white, size: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailsSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          _buildDetailRow(
              'Order number', '#${orderData['number'] ?? 'N/A'}', theme),
          const Divider(height: 24),
          _buildDetailRow(
              'Tracking Number', orderData['tracking'] ?? 'N/A', theme),
          const Divider(height: 24),
          _buildDetailRow(
              'Delivery address', 'SBI Building, Software Park', theme), // بيانات ثابتة مؤقتاً
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.textTheme.bodyMedium),
        Text(value,
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildProductListSection(ThemeData theme) {
    // دي بيانات وهمية للمنتجات جوه الطلب
    final products = isDelivered
        ? [
            {'name': 'Maxi Dress', 'quantity': 1, 'price': 68.00},
            {'name': 'Linen Dress', 'quantity': 1, 'price': 52.00},
          ]
        : [
            {'name': 'Sportwear Set', 'quantity': 1, 'price': 80.00},
            {'name': 'Cotton T-shirt', 'quantity': 1, 'price': 30.00},
          ];

    return Column(
      children: products.map((product) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${product['name']}  x${product['quantity']}',
                style: theme.textTheme.bodyLarge,
              ),
              Text(
                '\$${(product['price'] as double).toStringAsFixed(2)}',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildOrderSummarySection(ThemeData theme) {
    final subtotal = orderData['subtotal'] ?? 0.0;
    const shipping = 0.00; // من التصميم

    return Column(
      children: [
        _buildDetailRow(
            'Sub Total', '\$${subtotal.toStringAsFixed(2)}', theme),
        const SizedBox(height: 12),
        _buildDetailRow(
            'Shipping', '\$${shipping.toStringAsFixed(2)}', theme),
        const Divider(height: 24),
        _buildDetailRow(
            'Total', '\$${(subtotal + shipping).toStringAsFixed(2)}', theme),
      ],
    );
  }

  Widget _buildBottomButtons() {
    if (isDelivered) {
      // زي صورة order info-1.png
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'Return home',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                },
                isOutlined: true,
                textColor: Colors.black,
                backgroundColor: Colors.black, // for outline border
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppButton(
                text: 'Rate',
                onPressed: () {
                  print('Navigate to Rate Product');
                },
                backgroundColor: Colors.black,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else {
      // زي صورة order info-2.png
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppButton(
          text: 'Continue shopping',
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
          backgroundColor: Colors.black,
          textColor: Colors.white,
        ),
      );
    }
  }
}