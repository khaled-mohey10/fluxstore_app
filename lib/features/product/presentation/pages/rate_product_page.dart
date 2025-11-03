import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';
import 'package:glamour_app/core/widgets/app_button.dart';
import 'package:glamour_app/core/widgets/app_text_field.dart';

class RateProductPage extends StatefulWidget {
  const RateProductPage({super.key});

  @override
  State<RateProductPage> createState() => _RateProductPageState();
}

class _RateProductPageState extends State<RateProductPage> {
  int _rating = 4; 

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.card_giftcard, color: Colors.white),
                  const SizedBox(width: 12),
                  Text(
                    'Submit your review to get 5 points',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 40),

            _buildStarRating(),
            const SizedBox(height: 40),

            AppTextField(
              hintText: 'Would you like to write anything about this product?',
              maxLines: 6,
              maxLength: 50,
              style: theme.textTheme.bodyLarge,
              decoration: InputDecoration(
                counterText:
                    "50 characters", 
                counterStyle: theme.textTheme.bodySmall
                    ?.copyWith(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                _buildPhotoUploadButton(theme),
                const SizedBox(width: 16),
                _buildPhotoUploadButton(theme, isCamera: true),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AppButton(
          text: 'Submit Review',
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: Colors.black,
          textColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: index < _rating
                ? const Color(0xFF0D9B55) 
                : Colors.grey[400],
            size: 36,
          ),
        );
      }),
    );
  }

  Widget _buildPhotoUploadButton(ThemeData theme, {bool isCamera = false}) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Icon(
        isCamera ? Icons.camera_alt_outlined : Icons.image_outlined,
        color: Colors.grey[400],
        size: 30,
      ),
    );
  }
}