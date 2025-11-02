import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:glamour_app/core/constants/app_colors.dart';
import 'package:glamour_app/data/services/firebase_auth_service.dart';
import 'package:glamour_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:glamour_app/features/auth/presentation/pages/login_page.dart';
import 'package:glamour_app/features/auth/presentation/pages/signup_page.dart';
import 'package:glamour_app/features/home/presentation/pages/home_page.dart';
import 'package:glamour_app/features/orders/presentation/pages/my_orders_page.dart';
import 'package:glamour_app/features/orders/presentation/pages/order_info_page.dart';
import 'package:glamour_app/features/search/presentation/pages/search_screen.dart';
import 'package:glamour_app/screens/welcome_screen.dart';
import 'package:glamour_app/screens/onboarding_screen.dart';

import 'package:glamour_app/features/product/presentation/pages/product_detail_page.dart';
import 'package:glamour_app/features/checkout/presentation/pages/checkout_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GlamourApp());
}

class GlamourApp extends StatelessWidget {
  const GlamourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glamour',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.background,
          iconTheme: IconThemeData(color: AppColors.text),
          titleTextStyle: TextStyle(
            color: AppColors.text,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey[400],
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          showUnselectedLabels: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary, width: 2.0),
          ),
          labelStyle: TextStyle(color: AppColors.text),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(color: AppColors.text, fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: AppColors.text, fontSize: 28, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(color: AppColors.text, fontSize: 24, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(color: AppColors.text, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.grey[700], fontSize: 14),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          background: AppColors.background,
        ),
      ),

      home: StreamBuilder(
        stream: FirebaseAuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const WelcomeScreen();
          }
        },
      ),

      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/home': (context) => const HomePage(),
        '/search': (context) => const SearchScreen(),
        '/product-detail': (context) => const ProductDetailPage(),
        '/checkout': (context) => const CheckoutPage(),
        '/my-orders': (context) => const MyOrdersPage(),
        '/order-info': (context) => const OrderInfoPage(),

      },
    );
  }
}