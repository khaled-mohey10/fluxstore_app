import 'package:flutter/material.dart';
import 'package:glamour_app/core/widgets/app_button.dart';
import 'package:glamour_app/core/widgets/app_text_field.dart';
import 'package:glamour_app/data/services/firebase_auth_service.dart'; 

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleForgotPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final authService = FirebaseAuthService();
      await authService.sendPasswordResetEmail(
        context,
        _emailController.text.trim(),
      );

      if (mounted) {
        setState(() => _isLoading = false);
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  'Reset Password',
                  style: theme.textTheme.headlineMedium,   
                ),
                const SizedBox(height: 16),
                Text(
                  'Enter your email address and we\'ll send you a link to reset your password.',
                  style: theme.textTheme.bodyMedium,   
                ),
                const SizedBox(height: 48),
                AppTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                                     validator: (value) => (value == null || value.isEmpty || !value.contains('@'))
                      ? 'Please enter a valid email'
                      : null,
                ),
                const SizedBox(height: 32),
                AppButton(
                  text: 'SEND RESET LINK',
                  onPressed: _handleForgotPassword,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}