import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:online_ezzy/Features/AddShipmentOrder/add_shipment_order_view.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BottomItem(
                  index: 0,
                  currentIndex: currentIndex,
                  label: 'الرئيسية',
                  icon: Iconsax.home_2_copy,
                  onTap: onTabSelected,
                ),
                _BottomItem(
                  index: 1,
                  currentIndex: currentIndex,
                  label: 'السلة',
                  icon: Iconsax.shopping_cart_copy,
                  onTap: onTabSelected,
                ),
                const SizedBox(width: 56),
                _BottomItem(
                  index: 2,
                  currentIndex: currentIndex,
                  label: 'الشحنات',
                  icon: Iconsax.box_1_copy,
                  onTap: onTabSelected,
                ),
                _BottomItem(
                  index: 3,
                  currentIndex: currentIndex,
                  label: 'حسابي',
                  icon: Iconsax.user_copy,
                  onTap: onTabSelected,
                ),
              ],
            ),
            Positioned(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const AddShipmentOrderView(),
                    ),
                  );
                },              
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  const _BottomItem({
    required this.index,
    required this.currentIndex,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final int index;
  final int currentIndex;
  final String label;
  final IconData icon;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final isActive = currentIndex == index;
    final color = isActive ? AppColors.mainColor : AppColors.greyDark;

    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}

