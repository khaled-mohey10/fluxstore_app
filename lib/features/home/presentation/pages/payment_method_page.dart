import 'package:flutter/material.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Card Management',
                  style: theme.textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-new-card');
                    
                  },
                  child: Text(
                    'Add new+',
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            _buildCreditCard(),
            const SizedBox(height: 40),
            
            Center(
              child: Text(
                'or check out with',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Image.asset(
                'assets/images/payments.png',
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildCreditCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF4A90E2),
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'VISA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          Spacer(),
          Text(
            '4364   1345   8932   8378',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CARDHOLDER NAME\nSunie Pham',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                'VALID THRU\n05/24',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}