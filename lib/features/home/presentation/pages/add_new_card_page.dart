import 'package:flutter/material.dart';
import 'package:glamour_app/core/widgets/app_button.dart';
import 'package:glamour_app/core/widgets/app_text_field.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final _nameController = TextEditingController(text: 'Sunie Khaled');
  final _numberController = TextEditingController(text: '5412363272837284');
  final _expiresController = TextEditingController(text: '03/23');
  final _cvvController = TextEditingController(text: '999');

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiresController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new card'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- (Preview Card) ---
            _buildMastercardPreview(theme),
            const SizedBox(height: 32),

            // --- (Form Fields) ---
            AppTextField(
              controller: _nameController,
              labelText: 'Cardholder Name',
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _numberController,
              labelText: 'Card Number',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _expiresController,
                    labelText: 'Expires',
                    hintText: 'MM/YY',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    controller: _cvvController,
                    labelText: 'CVV',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AppButton(
          text: 'Add card',
          onPressed: () {
            // TODO: Implement save logic
            Navigator.pop(context);
          },
          backgroundColor: Colors.black,
          textColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMastercardPreview(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFF9A825), Color(0xFFF57F17)], 
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFEB001B), 
                shape: BoxShape.circle
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: 12,
                    child: Container(
                      width: 20, height: 20, 
                      decoration: BoxDecoration(
                        color: const Color(0xFFF79E1B).withOpacity(0.9), 
                        shape: BoxShape.circle
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(flex: 2),
          const Text(
            '**** **** **** ****',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
          const Spacer(flex: 1),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CARDHOLDER NAME\nNAME',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                'VALID THRU\nMM/YY',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}