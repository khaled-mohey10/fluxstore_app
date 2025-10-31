import 'package:flutter/material.dart';
import 'package:glamour_app/core/widgets/app_button.dart';

class OrderCompletedStep extends StatelessWidget {
  const OrderCompletedStep({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            style: theme.textTheme.headlineMedium,   
          ),
          const SizedBox(height: 40),
          
          Icon(
            Icons.check_circle_outline_rounded,
            size: 120,
            color: theme.primaryColor,   
          ),
          
          const SizedBox(height: 40),
          Text(
            'Thank you for your purchase.\nYou can view your order in \'My Orders\' section.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16, height: 1.5),   
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
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}