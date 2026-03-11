
import 'package:flutter/material.dart';
import 'package:online_ezzy/Features/Auth/login_view.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

import 'widgets/onboarding_app_bar.dart';
import 'widgets/onboarding_bottom_section.dart';
import 'widgets/onboarding_illustration_placeholder.dart';
import 'widgets/onboarding_title_section.dart';

class OnboradingView extends StatefulWidget {
  const OnboradingView({super.key});

  @override
  State<OnboradingView> createState() => _OnboradingViewState();
}

class _OnboradingViewState extends State<OnboradingView> {
  late final PageController _pageController;
  int _currentPage = 0;

  final List<_OnboardingPageData> _pages = const [
    _OnboardingPageData(
      title: 'اختر الباقة المناسبة لك',
      description: 'خطط مرنة لتوصيل الطرود تناسب احتياجاتك.',
      imagePath: 'assets/images/1.png',
    ),
    _OnboardingPageData(
      title: 'تتبع شحنتك بسهولة',
      description: 'تابع حالة طلباتك لحظة بلحظة من التطبيق.',
      imagePath: 'assets/images/2.png',
    ),
    _OnboardingPageData(
      title: 'توصيل سريع وآمن',
      description: 'أفضل خدمات التوصيل لتجربة مريحة وموثوقة.',
      imagePath: 'assets/images/3.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToLastPage() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _handleNext() {
    if (_currentPage == _pages.length - 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentPageData = _pages[_currentPage];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnboardingAppBar(onSkip: _goToLastPage),
              const SizedBox(height: 16),
              OnboardingTitleSection(
                title: currentPageData.title,
                textStyle: AppStyles.styleBold24(context),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingIllustrationPlaceholder(
                      assetPath: _pages[index].imagePath,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              OnboardingBottomSection(
                description: currentPageData.description,
                currentIndex: _currentPage,
                pageCount: _pages.length,
                onSkip: _goToLastPage,
                onNext: _handleNext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  final String title;
  final String description;
  final String imagePath;
}