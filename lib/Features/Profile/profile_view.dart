import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/login_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  Future<Map<String, String>> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('user_name') ?? 'ضيف',
      'email': prefs.getString('user_email') ?? '',
      'phone': prefs.getString('user_phone') ?? '',
      'isGuest': (prefs.getBool('is_guest') ?? false).toString(),
    };
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.setBool('is_guest', false);

    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginView()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: FutureBuilder(
          future: _loadUser(),
          builder: (context, snapshot) {
            final data = snapshot.data ?? const <String, String>{};
            final isGuest = data['isGuest'] == 'true';

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    const Icon(Icons.settings_outlined, color: AppColors.greyDark),
                    const Spacer(),
                    Text('حسابي', style: AppStyles.styleBold18(context)),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: AppColors.mainColor,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['name'] ?? 'ضيف',
                              style: AppStyles.styleBold16(context),
                            ),
                            const SizedBox(height: 6),
                            if ((data['email'] ?? '').isNotEmpty)
                              Row(
                                children: [
                                  const Icon(Icons.email_outlined, size: 16),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      data['email'] ?? '',
                                      style: AppStyles.styleRegular12(context)
                                          .copyWith(color: AppColors.greyDark),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            if ((data['phone'] ?? '').isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.phone_outlined, size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    data['phone'] ?? '',
                                    style: AppStyles.styleRegular12(context)
                                        .copyWith(color: AppColors.greyDark),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 160,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: AppColors.mainColor.withOpacity(0.4),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                                child: Text(
                                  isGuest ? 'تسجيل الدخول' : 'تعديل البيانات',
                                  style: AppStyles.styleRegular12(context)
                                      .copyWith(color: AppColors.mainColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      CircleAvatar(
                        radius: 34,
                        backgroundColor: AppColors.greyLight,
                        child: const Icon(Icons.person, size: 34),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _SectionCard(
                  title: 'خدمات أخرى',
                  items: const [
                    'احصل على استشارة',
                    'صندوق بريدي',
                  ],
                ),
                const SizedBox(height: 16),
                _SectionCard(
                  title: 'حسابي',
                  items: const [
                    'الطلبات',
                    'تفاصيل الطرود',
                    'العناوين',
                    'طرق الدفع',
                    'تفاصيل الحساب',
                    'التنبيهات',
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: () => _logout(context),
                    child: Text(
                      'تسجيل الخروج',
                      style: AppStyles.styleSemiBold14(context).copyWith(
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.items});

  final String title;
  final List<String> items;

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
          Text(title, style: AppStyles.styleBold14(context)),
          const SizedBox(height: 8),
          ...items.map(
            (t) => ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(t, style: AppStyles.styleRegular14(context)),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

