import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:online_ezzy/Features/Cart/cubit/cart_cubit.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();

  final _firstName = TextEditingController(text: 'Ahmed');
  final _lastName = TextEditingController(text: 'Ali');
  final _address1 = TextEditingController(text: '123 Street Name');
  final _postcode = TextEditingController(text: '10023');
  final _city = TextEditingController(text: 'Casablanca');
  final _state = TextEditingController(text: 'الخليل');
  final _country = TextEditingController(text: 'PS');
  final _email = TextEditingController(text: 'test0012@test0010.com');
  final _phone = TextEditingController(text: '0612345678');

  String _paymentMethod = 'stripe';
  final _manualPaymentDataKey = TextEditingController(text: 'payment_method');
  final _manualPaymentDataValue = TextEditingController(); // e.g. pi_... or any gateway value
  bool _savePaymentMethod = false;
  bool _stripeCardComplete = false;
  bool _stripeUsePaymentIntentId = true; // Default to the working Postman flow.

  bool _createAccount = false;
  final _password = TextEditingController();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _address1.dispose();
    _postcode.dispose();
    _city.dispose();
    _state.dispose();
    _country.dispose();
    _email.dispose();
    _phone.dispose();
    _manualPaymentDataKey.dispose();
    _manualPaymentDataValue.dispose();
    _password.dispose();
    super.dispose();
  }

  Map<String, dynamic> _billingAddress() {
    return {
      'first_name': _firstName.text.trim(),
      'last_name': _lastName.text.trim(),
      'address_1': _address1.text.trim(),
      'postcode': _postcode.text.trim(),
      'city': _city.text.trim(),
      'country': _country.text.trim(),
      'email': _email.text.trim(),
      'phone': _phone.text.trim(),
      'state': _state.text.trim(),
    };
  }

  List<Map<String, dynamic>> _buildStripePaymentData({
    required String key,
    required String value,
  }) {
    final billing = _billingAddress();
    return [
      {
        'key': key,
        'value': value,
      },
      {'key': 'billing_email', 'value': billing['email'] ?? ''},
      {'key': 'billing_first_name', 'value': billing['first_name'] ?? ''},
      {'key': 'billing_last_name', 'value': billing['last_name'] ?? ''},
      {'key': 'paymentMethod', 'value': 'stripe'},
      {'key': 'paymentRequestType', 'value': 'cc'},
      {'key': 'wc-stripe-new-payment-method', 'value': _savePaymentMethod},
    ];
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    List<Map<String, dynamic>> paymentData;

    if (_paymentMethod == 'stripe') {
      if (_stripeUsePaymentIntentId) {
        // This matches your working Postman request:
        // payment_data: [{ key: "payment_method", value: "pi_..." }]
        final pi = _manualPaymentDataValue.text.trim();
        if (pi.isEmpty || !pi.startsWith('pi_')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('أدخل PaymentIntent ID صحيح يبدأ بـ pi_')),
          );
          return;
        }
        paymentData = _buildStripePaymentData(
          key: 'payment_method',
          value: pi,
        );
      } else {
        // Card entry path: creates a PaymentMethod (pm_...). Note:
        // Many WooCommerce Stripe setups still require a server-generated PaymentIntent.
        if (!_stripeCardComplete) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('أكمل بيانات البطاقة أولاً')),
          );
          return;
        }

        final billing = _billingAddress();
        final billingDetails = BillingDetails(
          email: (billing['email'] ?? '').toString(),
          phone: (billing['phone'] ?? '').toString(),
          name: '${billing['first_name']} ${billing['last_name']}'.trim(),
          address: Address(
            city: (billing['city'] ?? '').toString(),
            country: (billing['country'] ?? '').toString(),
            line1: (billing['address_1'] ?? '').toString(),
            line2: '',
            state: (billing['state'] ?? '').toString(),
            postalCode: (billing['postcode'] ?? '').toString(),
          ),
        );

        PaymentMethod pm;
        try {
          pm = await Stripe.instance.createPaymentMethod(
            params: PaymentMethodParams.card(
              paymentMethodData: PaymentMethodData(
                billingDetails: billingDetails,
              ),
            ),
          );
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
          return;
        }

        paymentData = _buildStripePaymentData(
          key: 'stripe_source',
          value: pm.id, // pm_...
        );
      }
    } else {
      paymentData = [
        {
          'key': _manualPaymentDataKey.text.trim(),
          'value': _manualPaymentDataValue.text.trim(),
        },
      ];
    }

    final cubit = context.read<CartCubit>();
    final error = await cubit.checkout(
      billingAddress: _billingAddress(),
      shippingAddress: _billingAddress(),
      paymentMethod: _paymentMethod,
      paymentData: paymentData,
      createAccount: _createAccount,
      password: _createAccount ? _password.text : null,
    );

    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('إتمام الدفع', style: AppStyles.styleSemiBold16(context)),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _Section(
              title: 'بيانات الفاتورة',
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _Field(
                          controller: _firstName,
                          label: 'الاسم الأول',
                          validator: _req,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _Field(
                          controller: _lastName,
                          label: 'اسم العائلة',
                          validator: _req,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _Field(
                    controller: _email,
                    label: 'البريد الإلكتروني',
                    keyboardType: TextInputType.emailAddress,
                    validator: _req,
                  ),
                  const SizedBox(height: 12),
                  _Field(
                    controller: _phone,
                    label: 'رقم الهاتف',
                    keyboardType: TextInputType.phone,
                    validator: _req,
                  ),
                  const SizedBox(height: 12),
                  _Field(
                    controller: _address1,
                    label: 'العنوان',
                    validator: _req,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _Field(
                          controller: _city,
                          label: 'المدينة',
                          validator: _req,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _Field(
                          controller: _state,
                          label: 'المحافظة',
                          validator: _req,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _Field(
                          controller: _postcode,
                          label: 'الرمز البريدي',
                          validator: _req,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _Field(
                          controller: _country,
                          label: 'الدولة (ISO)',
                          validator: _req,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _Section(
              title: 'طريقة الدفع',
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _paymentMethod,
                    items: const [
                      DropdownMenuItem(value: 'stripe', child: Text('Stripe')),
                      DropdownMenuItem(value: 'cod', child: Text('Cash on delivery')),
                      DropdownMenuItem(value: 'bacs', child: Text('Bank transfer')),
                    ],
                    onChanged: (v) => setState(() => _paymentMethod = v ?? 'stripe'),
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_paymentMethod == 'stripe') ...[
                    SwitchListTile(
                      value: _stripeUsePaymentIntentId,
                      onChanged: (v) => setState(() => _stripeUsePaymentIntentId = v),
                      title: const Text('الدفع باستخدام PaymentIntent (pi_)'),
                      subtitle: const Text('هذا هو نفس أسلوب Postman الذي يعمل لديك'),
                    ),
                    const SizedBox(height: 8),
                    _Field(
                      controller: _manualPaymentDataValue,
                      label: _stripeUsePaymentIntentId
                          ? 'PaymentIntent ID (pi_...)'
                          : 'اتركه فارغاً (سيتم إنشاء pm_ من البطاقة)',
                      validator: _stripeUsePaymentIntentId ? _req : null,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.greyLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _stripeUsePaymentIntentId
                          ? Text(
                              'أدخل pi_ الحقيقي (مثل Postman).',
                              style: AppStyles.styleRegular12(context).copyWith(
                                color: AppColors.greyDark,
                              ),
                            )
                          : CardField(
                              onCardChanged: (card) {
                                setState(() => _stripeCardComplete = card?.complete ?? false);
                              },
                            ),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      value: _savePaymentMethod,
                      onChanged: (v) => setState(() => _savePaymentMethod = v),
                      title: const Text('حفظ وسيلة الدفع'),
                    ),
                  ] else ...[
                    _Field(
                      controller: _manualPaymentDataKey,
                      label: 'payment_data key',
                      validator: _req,
                    ),
                    const SizedBox(height: 12),
                    _Field(
                      controller: _manualPaymentDataValue,
                      label: 'payment_data value',
                      validator: _req,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            _Section(
              title: 'إنشاء حساب (اختياري)',
              child: Column(
                children: [
                  SwitchListTile(
                    value: _createAccount,
                    onChanged: (v) => setState(() => _createAccount = v),
                    title: const Text('إنشاء حساب'),
                  ),
                  if (_createAccount) ...[
                    const SizedBox(height: 8),
                    _Field(
                      controller: _password,
                      label: 'كلمة المرور',
                      obscureText: true,
                      validator: (v) =>
                          _createAccount ? _req(v) : null,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  foregroundColor: AppColors.white,
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
            const SizedBox(height: 12),
            Text(
              'ملاحظة: إذا ظهر خطأ "email exists" فهذا بسبب إعدادات المتجر للـ guest checkout مع بريد مسجل. يلزم تعديل إعدادات/فلتر في ووردبريس.',
              style: AppStyles.styleRegular12(context).copyWith(
                color: AppColors.greyDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _req(String? v) {
    if (v == null || v.trim().isEmpty) return 'مطلوب';
    return null;
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.styleBold14(context)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.greyLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

