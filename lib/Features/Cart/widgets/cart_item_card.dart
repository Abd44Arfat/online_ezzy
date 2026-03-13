import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class CartItemData {
  const CartItemData({
    required this.keyId,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantity,
    this.imagePath,
    this.imageUrl,
  });

  final String keyId;
  final String title;
  final String subtitle;
  final String price;
  final int quantity;
  final String? imagePath;
  final String? imageUrl;
}

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.data,
    required this.onDelete,
    required this.onQuantityChanged,
  });

  final CartItemData data;
  final VoidCallback onDelete;
  final ValueChanged<int> onQuantityChanged;

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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: data.imageUrl != null
                      ? Image.network(
                          data.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Iconsax.box_1_copy),
                        )
                      : Image.asset(
                          data.imagePath ?? 'assets/images/Vector.png',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Iconsax.box_1_copy),
                        ),
                ),
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
                'الكمية',
                style: AppStyles.styleRegular12(context).copyWith(
                  color: AppColors.greyDark,
                ),
              ),
              Row(
                children: [
                  _QtyBtn(
                    label: '+',
                    onTap: () => onQuantityChanged(data.quantity + 1),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${data.quantity}',
                    style: AppStyles.styleSemiBold14(context),
                  ),
                  const SizedBox(width: 10),
                  _QtyBtn(
                    label: '-',
                    onTap: data.quantity <= 1
                        ? null
                        : () => onQuantityChanged(data.quantity - 1),
                  ),
                ],
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

class _QtyBtn extends StatelessWidget {
  const _QtyBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: onTap == null ? AppColors.greyLight : AppColors.mainColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: onTap == null ? AppColors.greyMedium : AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
