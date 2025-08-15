// Test file to verify signup flow works correctly
// This is a test widget to simulate the signup process

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glamour_app/core/services/firebase_auth_service.dart';

class SignupFlowTest extends StatefulWidget {
  const SignupFlowTest({super.key});

  @override
  State<SignupFlowTest> createState() => _SignupFlowTestState();
}

class _SignupFlowTestState extends State<SignupFlowTest> {
  bool _isLoading = false;
  String _result = 'Ready to test';

  Future<void> _testSignup() async {
    setState(() => _isLoading = true);
    _result = 'Testing signup...';

    try {
      final authService = FirebaseAuthService();

      // Test with mock data
      final user = await authService.signUpWithEmailAndPassword(
        context,
        'test@example.com',
        'TestPassword123!',
        'Test User',
      );

      if (user != null) {
        _result = 'Signup successful! User: ${user.email}';
      } else {
        _result = 'Signup failed - user is null';
      }
    } catch (e) {
      _result = 'Error: $e';
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup Flow Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _testSignup,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Test Signup'),
            ),
            const SizedBox(height: 20),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
