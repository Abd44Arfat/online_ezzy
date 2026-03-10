import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.mainColor.withOpacity(0.1),
          child: Text(
            'ك',
            style: AppStyles.styleBold18(context).copyWith(
              color: AppColors.mainColor,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحباً كريم 👋',
                style: AppStyles.styleBold16(context),
              ),
              Text(
                'لديك 3 شحنات نشطة',
                style: AppStyles.styleRegular12(context).copyWith(
                  color: AppColors.greyDark,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.notification_copy),
          color: AppColors.greyDark,
        ),
      ],
    );
  }
}

