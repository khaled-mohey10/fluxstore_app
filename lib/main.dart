import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:glamour_app/core/constants/app_colors.dart';
import 'package:glamour_app/core/services/firebase_auth_service.dart';
import 'package:glamour_app/features/auth/presentation/pages/create_password_page.dart';
import 'package:glamour_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:glamour_app/features/auth/presentation/pages/login_page.dart';
import 'package:glamour_app/features/auth/presentation/pages/signup_page.dart';
import 'package:glamour_app/features/auth/presentation/pages/verification_page.dart';
import 'package:glamour_app/features/home/presentation/pages/home_page.dart';
import 'package:glamour_app/screens/welcome_screen.dart';
import 'package:glamour_app/screens/onboarding_screen.dart';

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
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuthService().authStateChanges,
        builder: (context, snapshot) {
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
        '/verification': (context) => VerificationPage(
          email: ModalRoute.of(context)!.settings.arguments as String,
        ),
        '/create-password': (context) => CreatePasswordPage(
          email: ModalRoute.of(context)!.settings.arguments as String,
        ),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
