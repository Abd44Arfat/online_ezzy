import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class CartPaymentSection extends StatelessWidget {
  const CartPaymentSection({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  /// (label, assetPath) - replace with your actual asset paths
  static const _options = [
    ('الدفع عن طريق الفيزا', 'assets/images/pay1.png'),
    ('Google pay', 'assets/images/pay2.png'),
    ('PayPal', 'assets/images/pay3.png'),
    ('Link', 'assets/images/pay4.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'طريقة الدفع',
            style: AppStyles.styleBold14(context),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            _options.length,
            (index) {
              final (label, assetPath) = _options[index];
              final isSelected = index == selectedIndex;
              return InkWell(
                onTap: () => onChanged(index),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 28,
                        width: 48,
                        child: Image.asset(
                          assetPath,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        label,
                        style: AppStyles.styleRegular14(context).copyWith(
                          color: isSelected ? AppColors.mainColor : AppColors.greyDark,
                        ),
                      ),
                      const Spacer(),
                     
                       Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                        size: 22,
                        color: isSelected ? AppColors.mainColor : AppColors.greyMedium,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
