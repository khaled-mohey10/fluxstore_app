import 'package:flutter/material.dart';
import 'package:glamour_app/features/checkout/presentation/pages/shipping_step.dart';
import 'package:glamour_app/features/checkout/presentation/pages/payment_step.dart';
import 'package:glamour_app/features/checkout/presentation/pages/order_completed_step.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPage();
}

class _CheckoutPage extends State<CheckoutPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _goToStep(int step) {
    setState(() {
      _currentStep = step;
    });
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool canPop = _currentStep != 2;

    return PopScope(
      canPop: canPop,
      child: Scaffold(
          
        appBar: AppBar(
          title: const Text('Check out'),
          centerTitle: true,
          automaticallyImplyLeading: canPop,
          leading: canPop
              ? IconButton(
                  icon: const Icon(Icons.arrow_back), 
                  onPressed: () {
                    if (_currentStep == 0) {
                      Navigator.pop(context);
                    } else {
                      _goToStep(_currentStep - 1);
                    }
                  },
                )
              : null,
        ),
        body: Column(
          children: [
            if (_currentStep < 2)
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                child: _CheckoutStepper(currentStep: _currentStep),
              ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ShippingStep(
                    onContinue: () => _goToStep(1),
                  ),
                  PaymentStep(
                    onPlaceOrder: () => _goToStep(2),
                  ),
                  const OrderCompletedStep(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckoutStepper extends StatelessWidget {
  final int currentStep;
  const _CheckoutStepper({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepIcon(Icons.location_on, 0, theme),
        _buildConnector(theme),
        _buildStepIcon(Icons.payment, 1, theme),
        _buildConnector(theme),
        _buildStepIcon(Icons.check_circle, 2, theme),
      ],
    );
  }

  Widget _buildStepIcon(IconData icon, int stepIndex, ThemeData theme) {
    bool isActive = currentStep >= stepIndex;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
         color: isActive ? theme.primaryColor : Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
         color: isActive ? theme.colorScheme.onPrimary : Colors.grey[400],
        size: 18,
      ),
    );
  }

  Widget _buildConnector(ThemeData theme) {
    return Expanded(
      child: Container(
        height: 2,
        color: theme.dividerColor,   
        margin: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}