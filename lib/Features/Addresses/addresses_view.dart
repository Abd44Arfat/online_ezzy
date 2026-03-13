import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class AddressesView extends StatelessWidget {
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                  const Spacer(),
                  Text(
                    'العناوين',
                    style: AppStyles.styleSemiBold16(context),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  _AddressCard(
                    title: 'عنوان الداخل',
                    buttonLabel: 'تعرف على الباقات',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const _AddressDetailsScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _AddressCard(
                    title: 'عنوان صيني',
                    buttonLabel: 'تعرف على الباقات',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const _MailboxScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _AddressCard(
                    title: 'عنوان امريكي',
                    buttonLabel: 'تعرف على الباقات',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const _MailboxScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.title,
    required this.buttonLabel,
    this.onTap,
  });

  final String title;
  final String buttonLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: AppColors.greyLight,
                  child: const Icon(
                    Icons.image,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppStyles.styleSemiBold16(context),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    buttonLabel,
                    style: AppStyles.styleSemiBold14(context).copyWith(
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

class _AddressDetailsScreen extends StatelessWidget {
  const _AddressDetailsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                  const Spacer(),
                  Text(
                    'عنوان الداخل',
                    style: AppStyles.styleSemiBold16(context),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: AppColors.greyLight,
                        child: const Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'الباقة التجريبية',
                          textAlign: TextAlign.center,
                          style: AppStyles.styleBold16(context).copyWith(
                            color: AppColors.mainColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '2.5\$',
                                style:
                                    AppStyles.styleBold16(context).copyWith(
                                  color: AppColors.mainColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'قيمة الباقة التجريبية',
                                style: AppStyles.styleRegular12(context),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const _FeatureRow(
                          text: 'تتيح لك الشراء حتى 3 طرود فقط',
                        ),
                        const _FeatureRow(
                          text:
                              'استخدام مرة واحدة ينتهي بعد إتمام 3 طلبات',
                        ),
                        const _FeatureRow(
                          text: 'استلام طلباتك وتجهيزها بعناية',
                        ),
                        const _FeatureRow(
                          text: 'إشعارات فورية بحالة الشحنات',
                        ),
                        const _FeatureRow(
                          text: 'متابعة الطلبات خطوة بخطوة',
                        ),
                        const _FeatureRow(
                          text: 'دعم سريع عبر واتساب على مدار الساعة',
                        ),
                        const _FeatureRow(
                          text:
                              'تخزين مجاني لمدة 3 أشهر لاختيار وقت الشحن الأنسب',
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mainColor,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              'احصل على الباقة',
                              style: AppStyles.styleSemiBold16(context)
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      _Dot(isActive: true),
                      SizedBox(width: 6),
                      _Dot(isActive: false),
                      SizedBox(width: 6),
                      _Dot(isActive: false),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 10 : 8,
      height: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.mainColor : AppColors.greyMedium,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 18,
            color: AppColors.mainColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppStyles.styleRegular12(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _MailboxScreen extends StatelessWidget {
  const _MailboxScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                ),
                const Spacer(),
                Text(
                  'صندوق بريدي',
                  style: AppStyles.styleSemiBold16(context),
                ),
                const Spacer(flex: 2),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text(
                    'لماذا الصندوق البريدي',
                  ),
                  SizedBox(height: 8),
                  _FeatureRow(
                    text:
                        'عنوان ثابت خاص بك (مثل صندوق بريد أمريكي).',
                  ),
                  _FeatureRow(
                    text: 'استقبال البريد والطرود من جميع شركات الشحن.',
                  ),
                  _FeatureRow(
                    text: 'إدارة بريدك بسهولة من التطبيق.',
                  ),
                  _FeatureRow(
                    text: 'خطة مرنة وحفظ محتوى الصندوق لفترة محددة.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

