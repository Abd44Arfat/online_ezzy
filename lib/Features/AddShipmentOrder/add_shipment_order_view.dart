import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

import 'widgets/add_shipment_app_bar.dart';
import 'widgets/add_shipment_plan_card.dart';

class AddShipmentOrderView extends StatelessWidget {
  const AddShipmentOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      AddShipmentPlanData(
        title: 'باقة 3 طرود',
        highlight: 'خيار مثالي للشحنات الصغيرة والمتوسطة',
        bulletPoints: const [
          'توصيل فائق في عدد من المدن',
          'تتبع الشحنة بشكل دقيق',
          'دعم فني مخصص على مدار الساعة',
        ],
        assetPath: 'assets/images/neworder.png',
      ),
      AddShipmentPlanData(
        title: 'باقة من 4 إلى 24 طرد',
        highlight: 'أفضل خيار للشحنات المتوسطة',
        bulletPoints: const [
          'تكلفة أقل لكل طرد',
          'تتبع كامل للشحنات',
          'مرونة في تحديد مواعيد الاستلام',
        ],
        assetPath: 'assets/images/neworder.png',
      ),
      AddShipmentPlanData(
        title: 'باقة مخصصة',
        highlight: 'تحكم كامل في عدد الطرود والوجهات',
        bulletPoints: const [
          'تحديد عدد الطرود حسب احتياجك',
          'خدمات إضافية حسب الطلب',
          'خصومات للشحنات المتكررة',
        ],
        assetPath: 'assets/images/Container.png',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AddShipmentAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'اختر الباقة المناسبة لك',
                    style: AppStyles.styleSemiBold18(context),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'اختر الباقة المناسبة لتوصيل طرودك.',
                    style: AppStyles.styleRegular12(context).copyWith(
                      color: AppColors.greyDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                itemBuilder: (context, index) {
                  final plan = plans[index];
                  return AddShipmentPlanCard(data: plan);
                },
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemCount: plans.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

