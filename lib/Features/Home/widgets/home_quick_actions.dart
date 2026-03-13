import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickActionData(
        title: 'اطلب توصيل',
        assetPath: 'assets/images/banner1.png',
      ),
      _QuickActionData(
        title: 'العناوين',
        assetPath: 'assets/images/تتبع شحنتك.png',
      ),
      _QuickActionData(
        title: 'تتبع شحنتك',
        assetPath: 'assets/images/banner2.png',
      ),
      _QuickActionData(
        title: 'خدمات مالية',
        assetPath: 'assets/images/banner3.png',
      ),
    ];

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = actions[index];
          return _QuickActionCard(data: item);
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: actions.length,
      ),
    );
  }
}

class _QuickActionData {
  const _QuickActionData({
    required this.title,
    required this.assetPath,
    this.isAddresses = false,
  });

  final String title;
  final String assetPath;
  final bool isAddresses;
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.data});

  final _QuickActionData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (data.isAddresses) {
          Navigator.of(context).pushNamed('/addresses');
        }
      },
      child: Container(
        width: 88,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.greyMedium.withOpacity(0.25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  data.assetPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.greyLight,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 24,
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: AppColors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                alignment: Alignment.center,
                child: Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: AppStyles.styleRegular10(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

