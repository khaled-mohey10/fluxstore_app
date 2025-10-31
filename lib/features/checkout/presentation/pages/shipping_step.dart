import 'package:flutter/material.dart';
import 'package:glamour_app/core/widgets/app_button.dart';
import 'package:glamour_app/core/widgets/app_text_field.dart';

class ShippingStep extends StatefulWidget {
  final VoidCallback onContinue;
  const ShippingStep({super.key, required this.onContinue});

  @override
  State<ShippingStep> createState() => _ShippingStepState();
}

class _ShippingStepState extends State<ShippingStep> {
  final _formKey = GlobalKey<FormState>();
  int _selectedShippingMethod = 0; 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STEP 1',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const Text(
                    'Shipping',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  
                  AppTextField(labelText: 'First name *', initialValue: 'Pham'),
                  const SizedBox(height: 16),
                  AppTextField(
                    labelText: 'Last name *',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    labelText: 'Country *',
                    suffixIcon: const Icon(Icons.keyboard_arrow_down),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(labelText: 'Street name *'),
                  const SizedBox(height: 16),
                  AppTextField(labelText: 'City *'),
                  const SizedBox(height: 16),
                  AppTextField(labelText: 'State / Province'),
                  const SizedBox(height: 16),
                  AppTextField(labelText: 'Zip-code *'),
                  const SizedBox(height: 16),
                  AppTextField(
                    labelText: 'Phone number *',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 32),
                  
                  const Text(
                    'Shipping method',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildShippingOption(
                    title: 'Free',
                    subtitle: 'Delivery from 4 to 7 business days',
                    price: '\$ 0.00',
                    value: 0,
                  ),
                  _buildShippingOption(
                    title: 'Delivery to home',
                    subtitle: 'Delivery from 4 to 6 business days',
                    price: '\$ 9.90',
                    value: 1,
                  ),
                  _buildShippingOption(
                    title: 'Fast Delivery',
                    subtitle: 'Delivery from 2 to 3 business days',
                    price: '\$ 9.90',
                    value: 2,
                  ),
                  
                  const SizedBox(height: 32),
                  const Text(
                    'Billing Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                   CheckboxListTile(
                    value: true,
                    onChanged: (val) {},
                    title: const Text('Copy address data from shipping'),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    activeColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: AppButton(
            text: 'Continue to payment',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onContinue();
              }
            },
            backgroundColor: Colors.black,
            textColor: Colors.white,
            borderRadius: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildShippingOption({
    required String title,
    required String subtitle,
    required String price,
    required int value,
  }) {
    return RadioListTile<int>(
      value: value,
      groupValue: _selectedShippingMethod,
      onChanged: (newValue) {
        setState(() {
          _selectedShippingMethod = newValue!;
        });
      },
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      secondary: Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
      activeColor: Colors.black,
      contentPadding: EdgeInsets.zero,
    );
  }
}