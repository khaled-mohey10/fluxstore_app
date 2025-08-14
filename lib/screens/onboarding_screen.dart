import 'package:flutter/material.dart';
import 'package:glamour_app/screens/auth/login_screen.dart';
import 'package:glamour_app/screens/auth/signup_screen.dart';
import 'package:glamour_app/services/auth_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> introScreens = [
    {
      'title': 'Discover Something New',
      'description': 'Special new arrivals just for you',
      'image': 'assets/images/intro1.png',
    },
    {
      'title': 'Update Trendy Outfit',
      'description': 'Favorite brands and hottest trends',
      'image': 'assets/images/intro2.png',
    },
    {
      'title': 'Explore Your True Style',
      'description': 'Relax and let us bring the style to you',
      'image': 'assets/images/intro3.png',
    },
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < introScreens.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _completeOnboarding() async {
    await AuthService().completeOnboarding();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Column(
            children: [
              Expanded(child: Container(color: Colors.white)),
              Expanded(child: Container(color: Colors.grey[300])),
            ],
          ),
          // PageView for images
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: introScreens.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      introScreens[index]['title']!,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      introScreens[index]['description']!,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Image.asset(introScreens[index]['image']!),
                  ],
                ),
              );
            },
          ),
          // Skip Button
          Positioned(
            top: 50,
            right: 24,
            child: TextButton(
              onPressed: _skipOnboarding,
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          // Footer
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Progress Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    introScreens.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: index == _currentPage
                            ? Colors.black
                            : Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Shopping Now Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SizedBox(
                    width: double.infinity, // جعل الزر يأخذ كامل العرض تقريبًا
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      child: const Text(
                        'Shopping Now',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: const BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
