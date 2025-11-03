import 'package:flutter/material.dart';
import 'package:glamour_app/features/auth/presentation/pages/login_page.dart';

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

  void _completeOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final double halfHeight = screenHeight * 0.55;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: halfHeight,
            child: Container(color: const Color(0xFF4B4B4B)),
          ),
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: introScreens.length,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        Text(
                          introScreens[index]['title']!,
                          style: theme.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          introScreens[index]['description']!,
                          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: halfHeight - 180,
                    child: Image.asset(
                      introScreens[index]['image']!,
                      height: 380,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: 50,
            right: 24,
            child: TextButton(
              onPressed: _completeOnboarding,
              child: Text(
                'Skip',
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: halfHeight,
            child: Column(
              children: [
                const Spacer(flex: 4),
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
                            ? Colors.white
                            : Colors.grey[600],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Shopping now'),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}