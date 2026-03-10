import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

import 'widgets/cart_app_bar.dart';
import 'widgets/cart_item_card.dart';
import 'widgets/cart_payment_section.dart';

class CartView extends StatefulWidget {
  const CartView({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int _selectedPaymentIndex = 0;

  late List<CartItemData> _items;

  @override
  void initState() {
    super.initState();
    _items = [
    CartItemData(
      title: 'باقة 3 طرود',
      subtitle: 'طلب توصيل',
      price: '\$30.00',
    ),
    CartItemData(
      title: 'العنوان الأمريكي',
      subtitle: 'الباقة الذهبية',
      price: '\$30.00',
    ),
    CartItemData(
      title: 'Wise Starter',
      subtitle: '120\$',
      price: '\$120',
    ),
    ];
  }

  void _onEmptyCart() {
    setState(() {
      _items.clear();
    });
  }

  void _onDeleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CartAppBar(onBack: widget.onBack),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Align(
                    child: TextButton.icon(
                      
                      onPressed: _onEmptyCart,
                      icon: Icon(Iconsax.refresh_copy, size: 18, color: AppColors.greyDark),
                      label: Text(
                        'تفريغ السلة',
                        style: AppStyles.styleRegular12(context).copyWith(
                          color: AppColors.greyDark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: _items.length + 1,
                itemBuilder: (context, index) {
                  if (index < _items.length) {
                    return CartItemCard(
                      data: _items[index],
                      onDelete: () => _onDeleteItem(index),
                    );
                  }
                  return CartPaymentSection(
                    selectedIndex: _selectedPaymentIndex,
                    onChanged: (i) => setState(() => _selectedPaymentIndex = i),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'إتمام الدفع',
                    style: AppStyles.styleSemiBold16(context).copyWith(
                      color: AppColors.white,
                    ),
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
