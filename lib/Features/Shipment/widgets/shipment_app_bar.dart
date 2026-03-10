import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class ShipmentAppBar extends StatelessWidget {
  const ShipmentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.search_normal_1_copy),
            color: AppColors.greyDark,
          ),
          Expanded(
            child: Text(
              'الشحنات',
              textAlign: TextAlign.center,
              style: AppStyles.styleSemiBold18(context),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.notification_copy),
                color: AppColors.greyDark,
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}

