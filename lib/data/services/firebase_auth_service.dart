import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(context, e);
      return null;
    }
  }

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await credential.user!.updateDisplayName(name);
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        await credential.user!.reload();
        return credential.user;
      }
      return credential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(context, e);
      return null;
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(
          context,
          'Error creating account: ${e.toString()}',
          isError: true,
        );
      }
      return null;
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(
    BuildContext context,
    String email,
  ) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showSnackBar(context, 'Password reset email sent!');
    } on FirebaseAuthException catch (e) {
      _handleAuthError(context, e);
    }
  }

  // Sign out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      _showSnackBar(context, 'Successfully signed out!');
    } catch (e) {
      _showSnackBar(context, 'Error signing out: ${e.toString()}', isError: true);
    }
  }

  // Handle auth errors
  void _handleAuthError(BuildContext context, FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'invalid-email':
        errorMessage = 'The email address is not valid.';
        break;
      case 'user-disabled':
        errorMessage = 'This user has been disabled.';
        break;
      case 'user-not-found':
        errorMessage = 'No user found with this email.';
        break;
      case 'wrong-password':
        errorMessage = 'Wrong password provided.';
        break;
      case 'email-already-in-use':
        errorMessage = 'The account already exists for that email.';
        break;
      case 'operation-not-allowed':
        errorMessage = 'Email/password accounts are not enabled.';
        break;
      case 'weak-password':
        errorMessage = 'The password provided is too weak.';
        break;
      case 'network-request-failed':
        errorMessage = 'Network error. Please check your connection.';
        break;
      default:
        errorMessage = 'An unknown error occurred. Please try again.';
    }
    _showSnackBar(context, errorMessage, isError: true);
  }
}