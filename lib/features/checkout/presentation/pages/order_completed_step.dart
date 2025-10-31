import 'package:flutter/material.dart';
import 'package:glamour_app/core/widgets/app_button.dart';

class OrderCompletedStep extends StatelessWidget {
  const OrderCompletedStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Text(
            'Order Completed',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          
          Icon(
            Icons.shopping_bag_outlined, 
            size: 120,
            color: Colors.grey[800],
          ),
          
          const SizedBox(height: 40),
          Text(
            'Thank you for your purchase.\nYou can view your order in \'My Orders\' section.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          const Spacer(),
          
          AppButton(
            text: 'Continue shopping',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
            backgroundColor: Colors.black,
            textColor: Colors.white,
            borderRadius: 30,
          ),
          const SizedBox(height: 20), 
        ],
      ),
    );
  }
}