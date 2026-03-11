import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class CustomShipmentAppBar extends StatelessWidget {
  const CustomShipmentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.mainColor),
          ),
          Expanded(
            child: Text(
              'باقة مخصصة',
              textAlign: TextAlign.center,
              style: AppStyles.styleBold18(context),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
