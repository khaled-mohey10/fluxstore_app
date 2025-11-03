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
    final theme = Theme.of(context);

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
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
                Text(
                  'Payment',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    _buildPaymentMethodCard(
                      icon: Icons.wallet,
                      label: 'Cash',
                      isSelected: _selectedPaymentMethod == 0,
                      onTap: () => setState(() => _selectedPaymentMethod = 0),
                      theme: theme,
                    ),
                    const SizedBox(width: 16),
                    _buildPaymentMethodCard(
                      icon: Icons.credit_card,
                      label: 'Credit Card',
                      isSelected: _selectedPaymentMethod == 1,
                      onTap: () => setState(() => _selectedPaymentMethod = 1),
                      theme: theme,
                    ),
                    const SizedBox(width: 16),
                     _buildPaymentMethodCard(
                      icon: Icons.more_horiz,
                      label: 'More',
                      isSelected: _selectedPaymentMethod == 2,
                      onTap: () => setState(() => _selectedPaymentMethod = 2),
                      theme: theme,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                _buildCreditCard(),
                
                const SizedBox(height: 24), 
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

                const SizedBox(height: 32),
                
                _buildSummaryRow('Product price', '\$110', theme),
                const SizedBox(height: 10),
                _buildSummaryRow('Shipping', 'Freeship', theme),
                Divider(height: 32, thickness: 1, color: theme.dividerColor),
                _buildSummaryRow('Subtotal', '\$110', theme, isBold: true),
                const SizedBox(height: 24),

                CheckboxListTile(
                  value: _agreeToTerms,
                  onChanged: (val) => setState(() => _agreeToTerms = val ?? false),
                  title: RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodyMedium,
                      children: [
                        const TextSpan(text: 'I agree to '),
                        TextSpan(
                          text: 'Terms and conditions',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                          ),
                        ),
                      ],
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  activeColor: theme.primaryColor,
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
    required ThemeData theme,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
                 color: isSelected ? theme.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? theme.primaryColor : theme.dividerColor,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onBackground),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onBackground)),
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