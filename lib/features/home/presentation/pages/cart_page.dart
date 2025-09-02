import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Cart Page\nComing Soon',
          style: TextStyle(color: Colors.white, fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
