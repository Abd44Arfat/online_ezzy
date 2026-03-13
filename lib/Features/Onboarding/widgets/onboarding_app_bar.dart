import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class OnboardingAppBar extends StatelessWidget {
  const OnboardingAppBar({super.key, required this.onSkip});

  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onSkip,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'تخطي',
                style: AppStyles.styleMedium14(context).copyWith(
                  color: AppColors.greyDark,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

