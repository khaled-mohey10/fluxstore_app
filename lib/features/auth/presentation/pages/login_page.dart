import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';
import 'package:glamour_app/core/constants/app_text_styles.dart';
import 'package:glamour_app/core/extensions/string_extensions.dart';
import 'package:glamour_app/core/widgets/app_button.dart';
import 'package:glamour_app/core/widgets/app_snackbar.dart';
import 'package:glamour_app/core/widgets/app_text_field.dart';
import 'package:glamour_app/core/services/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _showRegistrationSuccess = false;

  @override
  void initState() {
    super.initState();
    // Check if we came from registration
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        if (args['fromRegistration'] == true) {
          setState(() => _showRegistrationSuccess = true);
          // Show the registration success message
          AppSnackBar.showSuccess(
            context,
            'Registration successful! Please log in.',
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final authService = FirebaseAuthService();

      final user = await authService.signInWithEmailAndPassword(
        context,
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (mounted) {
        setState(() => _isLoading = false);
        if (user != null) {
          AppSnackBar.showSuccess(context, 'Login successful!');
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Log into your account'),
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
                Text(
                  'Log into your account',
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 48),
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
                  validator: (value) => value?.validateNotEmpty(
                    message: 'Please enter your password',
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: 32),
                AppButton(
                  text: 'LOG IN',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text('Sign Up'),
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
