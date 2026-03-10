import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class CartItemData {
  const CartItemData({
    required this.title,
    required this.subtitle,
    required this.price,
    this.imagePath,
  });

  final String title;
  final String subtitle;
  final String price;
  final String? imagePath;
}

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.data,
    required this.onDelete,
  });

  final CartItemData data;
  final VoidCallback onDelete;

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
          Row(
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.greyLight,
                ),
                child: 
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                         "assets/images/Vector.png",
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Iconsax.box_1_copy),
                        ),
                      )
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: AppStyles.styleSemiBold14(context),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data.subtitle,
                      style: AppStyles.styleRegular12(context).copyWith(
                        color: AppColors.greyDark,
                      ),
                    ),
                  ],
                ),
              ),
             
               TextButton.icon(
                onPressed: onDelete,
                icon: Icon(Iconsax.trash_copy, size: 16, color: AppColors.mainColor),
                label: Text(
                  'حذف',
                  style: AppStyles.styleRegular12(context).copyWith(
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                'السعر',
                style: AppStyles.styleRegular12(context).copyWith(
                  color: AppColors.greyDark,
                ),
              ),
              Text(
                data.price,
                style: AppStyles.styleSemiBold14(context).copyWith(
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
