import 'package:flutter/material.dart';
import 'package:online_ezzy/Features/AddShipmentOrder/add_shipment_order_view.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';
import 'package:online_ezzy/core/widgets/shipment_status_timeline.dart';

class ShipmentList extends StatelessWidget {
  const ShipmentList({
    super.key,
    required this.statusFilterIndex,
  });

  final int statusFilterIndex;

  @override
  Widget build(BuildContext context) {
    // Dummy data to match design; later you will replace with API data.
    final shipments = [
      const _ShipmentItemData(
        title: 'طرد أمازون',
        trackingNumber: '8742638H',
        statusLabel: 'في المستودع',
        statusColor: AppColors.mainColor,
        weightText: 'الوزن 2.5 كجم 12 مايو',
        currentStep: 2,
      ),
      const _ShipmentItemData(
        title: 'طرد فيكي آن',
        trackingNumber: '6654439',
        statusLabel: 'في المستودع',
        statusColor: AppColors.discountgreen,
        weightText: 'الوزن 1.2 كجم 9 مايو',
        currentStep: 3,
      ),
      const _ShipmentItemData(
        title: 'طرد علي إكسبريس',
        trackingNumber: '9927715',
        statusLabel: 'قيد التحضير',
        statusColor: AppColors.greyDark,
        weightText: 'الوزن 1.9 كجم 4 مايو',
        currentStep: 1,
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
      itemBuilder: (context, index) {
        if (index < shipments.length) {
          final item = shipments[index];
          return _ShipmentCard(data: item);
        }

        // Last item: empty-state like the design ("لا توجد شحنات حالياً")
        return const _EmptyShipmentsCard();
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: shipments.length + 1,
    );
  }
}

class _ShipmentItemData {
  const _ShipmentItemData({
    required this.title,
    required this.trackingNumber,
    required this.statusLabel,
    required this.statusColor,
    required this.weightText,
    required this.currentStep,
  });

  final String title;
  final String trackingNumber;
  final String statusLabel;
  final Color statusColor;
  final String weightText;
  final int currentStep;
}

class _ShipmentCard extends StatelessWidget {
  const _ShipmentCard({required this.data});

  final _ShipmentItemData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                                    height: 64,
                                    width: 64,
                                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.greyLight,
                                    ),
                                    child:  Image.asset('assets/images/Container.png'),
                                  ),
                  ),
                    const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: AppStyles.styleSemiBold14(context),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'رقم التتبع: ${data.trackingNumber}',
                      style: AppStyles.styleRegular12(context).copyWith(
                        color: AppColors.greyDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                 
                  ],
                ),
              ),
              const SizedBox(width: 12),
             _StatusPill(
                      label: data.statusLabel,
                      color: data.statusColor,
                    ),
            ],
            
          ),
          const SizedBox(height: 12),
          ShipmentStatusTimeline(currentStep: data.currentStep),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.weightText,
                style: AppStyles.styleRegular11(context).copyWith(
                  color: AppColors.greyDark,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'عرض التفاصيل',
                      style: AppStyles.styleRegular12(context).copyWith(
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'تتبع',
                      style: AppStyles.styleSemiBold12(context).copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppStyles.styleRegular11(context).copyWith(
          color: color,
        ),
      ),
    );
  }
}

class _EmptyShipmentsCard extends StatelessWidget {
  const _EmptyShipmentsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'لا توجد شحنات حالياً',
            style: AppStyles.styleSemiBold14(context).copyWith(
              color: AppColors.greyDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'ابدأ بإضافة شحنة جديدة',
            style: AppStyles.styleRegular12(context).copyWith(
              color: AppColors.greyMedium,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AddShipmentOrderView(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'اطلب الآن',
                style: AppStyles.styleSemiBold12(context).copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


