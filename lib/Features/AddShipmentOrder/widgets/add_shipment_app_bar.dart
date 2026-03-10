import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class AddShipmentAppBar extends StatelessWidget {
  const AddShipmentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            color: AppColors.black,
          ),
          const SizedBox(width: 4),
          Text(
            'طلب توصيل',
            style: AppStyles.styleSemiBold16(context),
          ),
        ],
      ),
    );
  }
}

