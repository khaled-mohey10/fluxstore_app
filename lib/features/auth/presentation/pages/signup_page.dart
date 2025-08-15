import 'package:flutter/material.dart';
import 'package:glamour_app/core/extensions/string_extensions.dart';
import 'package:glamour_app/core/widgets/app_button.dart';
import 'package:glamour_app/core/widgets/app_snackbar.dart';
import 'package:glamour_app/core/widgets/app_text_field.dart';
import 'package:glamour_app/core/services/firebase_auth_service.dart';
import 'package:glamour_app/features/auth/presentation/pages/login_page.dart';

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
      setState(() => _isLoading = true);

      final authService = FirebaseAuthService();

      final user = await authService.signUpWithEmailAndPassword(
        context,
        _emailController.text.trim(),
        _passwordController.text,
        _nameController.text.trim(),
      );

      // Always reset loading state
      if (mounted) {
        setState(() => _isLoading = false);

        // Only navigate if user was created successfully
        if (user != null) {
          // Use a short delay to ensure UI updates
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create your account'),
        backgroundColor: Colors.white,
        elevation: 0,
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
                const Text(
                  'Start your account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 48),
                AppTextField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  validator: (value) => value?.validateNotEmpty(
                    message: 'Please enter your name',
                  ),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value?.validateEmail(),
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
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) => value?.validatePassword(),
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
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  validator: (value) => value?.validateMatch(
                    _passwordController.text,
                    message: 'Passwords do not match',
                  ),
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
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text('Log In'),
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
