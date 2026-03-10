import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class OnboardingBottomSection extends StatelessWidget {
  const OnboardingBottomSection({
    super.key,
    required this.description,
    required this.currentIndex,
    required this.pageCount,
    required this.onSkip,
    required this.onNext,
  });

  final String description;
  final int currentIndex;
  final int pageCount;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  bool get _isLastPage => currentIndex == pageCount - 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppStyles.styleMedium20(context).copyWith(
            color: AppColors.black,
          ),
        ),
     
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              _isLastPage ? 'ابدأ الآن' : 'التالي',
              style: AppStyles.styleSemiBold16(context).copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
           Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pageCount,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _PageDot(isActive: index == currentIndex),
            ),
          ),
        ),
      ],
    );
  }
}

class _PageDot extends StatelessWidget {
  const _PageDot({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.mainColor : AppColors.greyMedium,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

