import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class AddShipmentPlanData {
  AddShipmentPlanData({
    required this.title,
    required this.highlight,
    required this.bulletPoints,
    required this.assetPath,
  });

  final String title;
  final String highlight;
  final List<String> bulletPoints;
  final String assetPath;
}

class AddShipmentPlanCard extends StatelessWidget {
  const AddShipmentPlanCard({super.key, required this.data});

  final AddShipmentPlanData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.greyMedium.withOpacity(0.3),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                data.assetPath,
                height: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    width: 120,
                    color: AppColors.greyLight,
                    child: const Icon(Icons.local_shipping_outlined, size: 40),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            data.title,
            style: AppStyles.styleBold14(context),
          ),
          const SizedBox(height: 4),
          Text(
            data.highlight,
            style: AppStyles.styleRegular12(context).copyWith(
              color: AppColors.greyDark,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.bulletPoints
                .map(
                  (text) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline_outlined,
                          size: 16,
                          color: AppColors.mainColor,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            text,
                            style: AppStyles.styleRegular12(context).copyWith(
                              color: AppColors.greyDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: proceed with this plan
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'احصل على الباقة',
                style: AppStyles.styleSemiBold14(context).copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

