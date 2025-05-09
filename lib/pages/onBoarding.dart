import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_sqflite_getx/pages/login_page.dart';
import 'package:login_sqflite_getx/pages/register_page.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  final RxInt currentPage = 0.obs;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'title': 'Welcome to To Do List',
      'description': 'Manage your tasks with ease and stay organized throughout your day',
      'icon':  Icons.check_circle_outline,
      'iconColor': const Color(0xFF1D5A8C),
      'gradientColors': [const Color.fromARGB(255, 217, 245, 249), const Color.fromARGB(255, 169, 191, 230)],
    },
    {
      'title': 'Create and Organize',
      'description': 'Create tasks, set priorities, and organize them in different categories',
      'icon': Icons.dashboard_customize,
      'iconColor': const Color(0xFF4CAF50),
      'gradientColors': [const Color.fromARGB(255, 217, 248, 219), const Color.fromARGB(255, 178, 242, 188)],
    },
    {
      'title': 'Track Your Progress',
      'description': 'Keep track of your completed tasks and monitor your productivity',
      'icon': Icons.analytics,
      'iconColor': const Color(0xFFF44336),
      'gradientColors': [const Color.fromARGB(255, 248, 223, 233), const Color.fromARGB(255, 234, 181, 189)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      currentPage.value = _pageController.page?.round() ?? 0;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // PageView builder
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(
                    context,
                    _onboardingData[index]['title']!,
                    _onboardingData[index]['description']!,
                    _onboardingData[index]['icon'],
                    _onboardingData[index]['iconColor'],
                    _onboardingData[index]['gradientColors'],
                  );
                },
              ),
            ),

            // Bottom section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                children: [
                  // Page indicator
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: currentPage.value == index ? 24.0 : 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: currentPage.value == index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  )),

                  const SizedBox(height: 32.0),

                  // Get started button
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.off(() => LoginPage()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            'GET STARTED',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0),

                  // Sign up link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => RegisterPage()),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.primary,
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(
      BuildContext context, 
      String title, 
      String description, 
      IconData icon, 
      Color iconColor,
      List<Color> gradientColors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Container with gradient background
          Container(
            height: 220,
            width: 220,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Icon(
                  icon,
                  size: 100,
                  color: iconColor.withOpacity(0.9),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}