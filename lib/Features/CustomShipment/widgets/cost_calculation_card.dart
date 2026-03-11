import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class CostCalculationCard extends StatelessWidget {
  const CostCalculationCard({
    super.key,
    required this.packageTotal,
    required this.tax,
    required this.total,
  });

  final double packageTotal;
  final double tax;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.greyMedium.withOpacity(0.3)),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CostRow(label: 'باقة الجملة ${packageTotal.toInt()}\$', value: '\$${packageTotal.toStringAsFixed(0)}'),
          const SizedBox(height: 8),
          _CostRow(label: 'الضريبة ${tax.toInt()}\$', value: '\$${tax.toStringAsFixed(0)}'),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الإجمالي:',
                style: AppStyles.styleBold16(context).copyWith(
                  color: AppColors.mainColor,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(0)}',
                style: AppStyles.styleBold16(context).copyWith(
                  color: AppColors.mainColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CostRow extends StatelessWidget {
  const _CostRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyles.styleRegular14(context).copyWith(
            color: AppColors.greyDark,
          ),
        ),
        Text(
          value,
          style: AppStyles.styleRegular14(context).copyWith(
            color: AppColors.greyDark,
          ),
        ),
      ],
    );
  }
}
