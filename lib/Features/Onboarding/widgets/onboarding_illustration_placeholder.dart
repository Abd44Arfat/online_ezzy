import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class OnboardingIllustrationPlaceholder extends StatelessWidget {
  const OnboardingIllustrationPlaceholder({
    super.key,
    required this.assetPath,
  });

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          color: AppColors.greyLight,
          child: Image.asset(
            assetPath,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text(
                  'Onboarding Illustration',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

