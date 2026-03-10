import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class ShipmentSearchBar extends StatelessWidget {
  const ShipmentSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'ابحث برقم الشحنة',
        hintStyle: AppStyles.styleRegular12(context).copyWith(
          color: AppColors.greyMedium,
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Iconsax.search_normal_1_copy, size: 18),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

