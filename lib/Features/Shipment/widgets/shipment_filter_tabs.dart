import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class ShipmentFilterTabs extends StatelessWidget {
  const ShipmentFilterTabs({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static const _tabs = [
    'الكل',
    'في المستودع',
    'تم الطلب',
    'تم الشحن',
    'الملغاة',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onChanged(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.mainColor : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isSelected
                      ? AppColors.mainColor
                      : AppColors.greyMedium.withOpacity(0.4),
                ),
              ),
              child: Center(
                child: Text(
                  _tabs[index],
                  style: AppStyles.styleRegular12(context).copyWith(
                    color: isSelected ? AppColors.white : AppColors.greyDark,
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: _tabs.length,
      ),
    );
  }
}

