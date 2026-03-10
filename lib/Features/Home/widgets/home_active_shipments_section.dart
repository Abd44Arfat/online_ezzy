import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';
import 'package:online_ezzy/core/widgets/shipment_status_timeline.dart';

class HomeActiveShipmentsSection extends StatefulWidget {
  const HomeActiveShipmentsSection({super.key});

  @override
  State<HomeActiveShipmentsSection> createState() =>
      _HomeActiveShipmentsSectionState();
}

class _HomeActiveShipmentsSectionState
    extends State<HomeActiveShipmentsSection> {
  late final PageController _controller;
  int _currentPage = 0;

  final List<_ShipmentCardData> _shipments = const [
    _ShipmentCardData(
      title: 'طرد أمازون',
      trackingNumber: '8742638H',
      currentStep: 2,
    ),
    _ShipmentCardData(
      title: 'طرد eBay',
      trackingNumber: 'AB12345',
      currentStep: 1,
    ),
    _ShipmentCardData(
      title: 'طرد متجر آخر',
      trackingNumber: 'ZX98765',
      currentStep: 3,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'الشحنات النشطة',
              style: AppStyles.styleBold14(context),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'عرض الكل',
                style: AppStyles.styleRegular12(context).copyWith(
                  color: AppColors.mainColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 156,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _shipments.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final data = _shipments[index];
                    return _ShipmentCard(data: data);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _shipments.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 6,
                    width: _currentPage == index ? 14 : 6,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.mainColor
                          : AppColors.greyMedium.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShipmentCardData {
  const _ShipmentCardData({
    required this.title,
    required this.trackingNumber,
    required this.currentStep,
  });

  final String title;
  final String trackingNumber;
  final int currentStep;
}

class _ShipmentCard extends StatelessWidget {
  const _ShipmentCard({required this.data});

  final _ShipmentCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.greyLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                ),
                child: Image.asset('assets/images/📦.png'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: AppStyles.styleSemiBold14(context),
                    ),
                    Text(
                      '${data.trackingNumber} رقم الشحنة',
                      style: AppStyles.styleRegular12(context).copyWith(
                        color: AppColors.greyDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ShipmentStatusTimeline(currentStep: data.currentStep),
        ],
      ),
    );
  }
}


