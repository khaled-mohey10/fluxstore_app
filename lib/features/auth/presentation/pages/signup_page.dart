import 'package:flutter/material.dart';
import 'package:glamour_app/core/widgets/app_button.dart';
import 'package:glamour_app/core/widgets/app_text_field.dart';
import 'package:glamour_app/data/services/firebase_auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() => _isLoading = true);

      final authService = FirebaseAuthService();

      final user = await authService.signUpWithEmailAndPassword(
        context,
        _emailController.text.trim(),
        _passwordController.text,
        _nameController.text.trim(),
      );

      if (mounted) {
        setState(() => _isLoading = false);
        if (user != null) {
          await Future.delayed(const Duration(milliseconds: 100));
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
              arguments: {'fromRegistration': true},
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                  'Create Account',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Start your journey with us.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 48),
                AppTextField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Please enter your email' : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) => (value == null || value.length < 6)
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  validator: (value) =>
                      (value != _passwordController.text) ? 'Passwords do not match' : null,
                ),
                const SizedBox(height: 32),
                AppButton(
                  text: 'SIGN UP',
                  onPressed: _handleSignup,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}