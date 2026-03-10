import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class ShipmentStatusTimeline extends StatelessWidget {
  const ShipmentStatusTimeline({
    super.key,
    required this.currentStep,
  });

  /// 0-based step index coming from API (e.g. 0 = لم الطلب, 4 = تم التسليم)
  final int currentStep;

  static const List<String> labels = [
    'لم الطلب',
    'لم الشحن',
    'المستودع',
    'قيد النقل',
    'تم التسليم',
  ];

  @override
  Widget build(BuildContext context) {
    final clampedStep =
        currentStep.clamp(0, labels.length - 1).toInt(); // safety for API

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final totalWidth = constraints.maxWidth;
                final segmentCount = labels.length - 1;
                final progressFraction =
                    segmentCount == 0 ? 0.0 : clampedStep / segmentCount;

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Grey base line
                    Positioned.fill(
                      top: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.greyMedium.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                    // Red progress line
                    Positioned(
                      top: 14,
                      right: 8,
                      child: Container(
                        height: 2,
                        width: totalWidth * progressFraction -
                            16 * progressFraction,
                        color: AppColors.mainColor,
                      ),
                    ),
                    // Circles
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        labels.length,
                        (index) => _StatusCircle(
                          isDone: index < clampedStep,
                          isCurrent: index == clampedStep,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              labels.length,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    labels[index],
                    textAlign: TextAlign.center,
                    style: AppStyles.styleRegular10(context).copyWith(
                      color: index <= clampedStep
                          ? AppColors.mainColor
                          : AppColors.greyDark,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusCircle extends StatelessWidget {
  const _StatusCircle({
    required this.isDone,
    required this.isCurrent,
  });

  final bool isDone;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color fillColor;
    Color? innerCircleColor;
    Widget? icon;

    if (isDone) {
      borderColor = AppColors.mainColor;
      fillColor = AppColors.mainColor;
      icon = const Icon(Icons.check, size: 14, color: Colors.white);
    } else if (isCurrent) {
      borderColor = AppColors.mainColor;
      fillColor = AppColors.mainColor;
      innerCircleColor = Colors.white; // white dot/ring effect for current step
      icon = null;
    } else {
      borderColor = AppColors.greyMedium;
      fillColor = AppColors.white;
      icon = null;
    }

    return SizedBox(
      height: 20,
      width: 20,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: fillColor,
              border: Border.all(color: borderColor, width: 2),
            ),
          ),
          if (innerCircleColor != null)
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: innerCircleColor,
              ),
            ),
          if (icon != null) Center(child: icon),
        ],
      ),
    );
  }
}

