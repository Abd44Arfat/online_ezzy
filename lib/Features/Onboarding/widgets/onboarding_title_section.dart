import 'package:flutter/material.dart';

class OnboardingTitleSection extends StatelessWidget {
  const OnboardingTitleSection({
    super.key,
    required this.title,
    required this.textStyle,
  });

  final String title;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: textStyle,
    );
  }
}

