import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';
import 'package:glamour_app/screens/onboarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome_hero.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  Text(
                    'Welcome to Glamour',
                    style: theme.textTheme.headlineLarge
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Discover everything new',
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.white70), 
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 3),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.text, 
                      ),
                      child: const Text(
                        'Getting Started',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}