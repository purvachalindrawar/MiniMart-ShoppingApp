import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mini_mart/core/onboarding/onboarding_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _completeOnboarding() {
    ref.read(onboardingCompletedProvider.notifier).completeOnboarding();
    context.goNamed('home');
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildPage(
        context,
        title: 'Welcome to MiniMart',
        subtitle: 'Browse fresh groceries and daily essentials in one place.',
        icon: Icons.local_grocery_store,
      ),
      _buildPage(
        context,
        title: 'Fast search & filters',
        subtitle:
            'Quickly find products with search, categories, and smart filters.',
        icon: Icons.search,
      ),
      _buildPage(
        context,
        title: 'Cart & favorites',
        subtitle:
            'Add items to your cart, save favorites, and manage everything easily.',
        icon: Icons.shopping_cart_checkout,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) => pages[index],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (index) {
                final isActive = index == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                  width: isActive ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage == pages.length - 1) {
                      _completeOnboarding();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      _currentPage == pages.length - 1
                          ? 'Get started'
                          : 'Next',
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: _completeOnboarding,
              child: const Text('Skip for now'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 96,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
