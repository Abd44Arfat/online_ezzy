import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          if (onBack != null)
            IconButton(
              onPressed: onBack,
              icon: Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.mainColor),
            ),
          Expanded(
            child: Text(
              'السلة',
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
