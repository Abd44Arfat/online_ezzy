import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

import 'widgets/cost_calculation_card.dart';
import 'widgets/custom_shipment_app_bar.dart';
import 'widgets/parcel_input_group.dart';

class CustomShipmentView extends StatefulWidget {
  const CustomShipmentView({super.key});

  @override
  State<CustomShipmentView> createState() => _CustomShipmentViewState();
}

class _CustomShipmentViewState extends State<CustomShipmentView> {
  final List<_ParcelData> _parcels = [
    _ParcelData(length: 5, width: 10, height: 20, isConfirmed: false),
    _ParcelData(length: 5, width: 10, height: 20, isConfirmed: false),
  ];

  /// Price per 100 cm³ volume (adjust as needed)
  static const double _pricePer100Cm3 = 2.0;
  static const double _taxRate = 0.10;

  bool get _hasConfirmedParcel =>
      _parcels.any((p) => p.isConfirmed);

  double get _packageTotal {
    double sum = 0;
    for (final p in _parcels) {
      if (p.isConfirmed) {
        final volume = p.length * p.width * p.height;
        sum += (volume / 100) * _pricePer100Cm3;
      }
    }
    return sum;
  }

  double get _tax => _packageTotal * _taxRate;
  double get _total => _packageTotal + _tax;

  void _onConfirmParcel(int index, int length, int width, int height) {
    setState(() {
      if (index < _parcels.length) {
        _parcels[index] = _ParcelData(
          length: length,
          width: width,
          height: height,
          isConfirmed: true,
        );
      }
    });
  }

  void _addParcel() {
    setState(() {
      _parcels.add(_ParcelData(length: 5, width: 10, height: 20, isConfirmed: false));
    });
  }

  void _addToCart() {
    // TODO: add custom shipment to cart
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomShipmentAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تفاصيل الطرد',
                      style: AppStyles.styleBold16(context),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(
                      _parcels.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ParcelInputGroup(
                          initialLength: '${_parcels[index].length}',
                          initialWidth: '${_parcels[index].width}',
                          initialHeight: '${_parcels[index].height}',
                          onConfirm: (l, w, h) => _onConfirmParcel(index, l, w, h),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _addParcel,
                      icon: Icon(Icons.add, size: 18, color: AppColors.mainColor),
                      label: Text(
                        'إضافة طرد آخر',
                        style: AppStyles.styleRegular14(context).copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    if (_hasConfirmedParcel) ...[
                      const SizedBox(height: 24),
                      Text(
                        'حساب التكلفة',
                        style: AppStyles.styleBold16(context),
                      ),
                      const SizedBox(height: 12),
                      CostCalculationCard(
                        packageTotal: _packageTotal,
                        tax: _tax,
                        total: _total,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (_hasConfirmedParcel)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'اضافة الي السلة: \$${_total.toStringAsFixed(0)}',
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

class _ParcelData {
  _ParcelData({
    required this.length,
    required this.width,
    required this.height,
    this.isConfirmed = false,
  });

  final int length;
  final int width;
  final int height;
  final bool isConfirmed;
}
