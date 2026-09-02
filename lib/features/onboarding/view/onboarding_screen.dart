import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import 'widgets/dots_indicator.dart';
import 'widgets/onboarding_page.dart';
import '../model/onboarding_model.dart';
import 'welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  void _goToNextPage() {
    if (_currentIndex == OnboardingContent.pages.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentIndex != 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentIndex == OnboardingContent.pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: _skip,
                  child: Text('SKIP', style: AppTextStyles.mutedLabel),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: OnboardingContent.pages.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) =>
                    OnboardingPage(data: OnboardingContent.pages[index]),
              ),
            ),
            DotsIndicator(
              itemCount: OnboardingContent.pages.length,
              currentIndex: _currentIndex,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _currentIndex == 0 ? null : _goToPreviousPage,
                    child: Text(
                      'BACK',
                      style: AppTextStyles.mutedLabel.copyWith(
                        color: _currentIndex == 0
                            ? Colors.transparent
                            : AppColors.textMuted,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _goToNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(120, 52),
                    ),
                    child: Text(
                      isLastPage ? 'GET STARTED' : 'NEXT',
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
