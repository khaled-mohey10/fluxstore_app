import 'package:flutter/material.dart';
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
        title: const Text('Share your feedback'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'What is your opinion of GemStore?',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            _buildStarRating(),
            const SizedBox(height: 40),
            AppTextField(
              hintText: 'Would you like to write anything about this product?',
              maxLines: 6,
              minLines: 6,
              style: theme.textTheme.bodyLarge,
              decoration: InputDecoration(
                hintStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
                alignLabelWithHint: true,
                contentPadding: const EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: theme.primaryColor, width: 2.0),
                ),
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
          text: 'Send feedback',
          onPressed: () {
            _showFeedbackDialog(context);
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
            color: index < _rating ? Colors.black : Colors.grey[400],
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
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Icon(
        isCamera ? Icons.camera_alt_outlined : Icons.image_outlined,
        color: Colors.grey[500],
        size: 30,
      ),
    );
  }

  Future<void> _showFeedbackDialog(BuildContext context) {
    final theme = Theme.of(context);

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: theme.primaryColor,
                  size: 64,
                ),
                const SizedBox(height: 24),
                Text(
                  'Thank you for your feedback!',
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  'We appreciated your feedback. We\'ll use your feedback to improve your experience.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                AppButton(
                  text: 'Done',
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); 
                    Navigator.of(context).pop(); 
                  },
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}