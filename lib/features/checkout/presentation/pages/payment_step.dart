import 'package:flutter/material.dart';
import 'package:glamour_app/core/widgets/app_button.dart';

class PaymentStep extends StatefulWidget {
  final VoidCallback onPlaceOrder;
  const PaymentStep({super.key, required this.onPlaceOrder});

  @override
  State<PaymentStep> createState() => _PaymentStepState();
}

class _PaymentStepState extends State<PaymentStep> {
  int _selectedPaymentMethod = 1;
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'STEP 2',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const Text(
                  'Payment',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    _buildPaymentMethodCard(
                      icon: Icons.wallet,
                      label: 'Cash',
                      isSelected: _selectedPaymentMethod == 0,
                      onTap: () => setState(() => _selectedPaymentMethod = 0),
                    ),
                    const SizedBox(width: 16),
                    _buildPaymentMethodCard(
                      icon: Icons.credit_card,
                      label: 'Credit Card',
                      isSelected: _selectedPaymentMethod == 1,
                      onTap: () => setState(() => _selectedPaymentMethod = 1),
                    ),
                    const SizedBox(width: 16),
                     _buildPaymentMethodCard(
                      icon: Icons.more_horiz,
                      label: 'More',
                      isSelected: _selectedPaymentMethod == 2,
                      onTap: () => setState(() => _selectedPaymentMethod = 2),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                _buildCreditCard(),
                const SizedBox(height: 32),
                
                _buildSummaryRow('Product price', '\$110'),
                const SizedBox(height: 10),
                _buildSummaryRow('Shipping', 'Freeship'),
                const Divider(height: 32, thickness: 1),
                _buildSummaryRow('Subtotal', '\$110', isBold: true),
                const SizedBox(height: 24),

                CheckboxListTile(
                  value: _agreeToTerms,
                  onChanged: (val) => setState(() => _agreeToTerms = val ?? false),
                  title: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(text: 'I agree to '),
                        TextSpan(
                          text: 'Terms and conditions',
                          style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  activeColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: AppButton(
            text: 'Place my order',
            onPressed: _agreeToTerms ? widget.onPlaceOrder : null,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            borderRadius: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodCard({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.grey[300]!,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.white : Colors.black),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
            ],
          ),
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

  Widget _buildSummaryRow(String title, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: isBold ? Colors.black : Colors.grey.shade600,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}