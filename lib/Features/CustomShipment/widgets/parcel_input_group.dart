import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_ezzy/core/utils/styles/app_styles.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

class ParcelInputGroup extends StatefulWidget {
  const ParcelInputGroup({
    super.key,
    required this.onConfirm,
    this.initialLength,
    this.initialWidth,
    this.initialHeight,
  });

  final void Function(int length, int width, int height) onConfirm;
  final String? initialLength;
  final String? initialWidth;
  final String? initialHeight;

  @override
  State<ParcelInputGroup> createState() => _ParcelInputGroupState();
}

class _ParcelInputGroupState extends State<ParcelInputGroup> {
  late final TextEditingController _lengthController;
  late final TextEditingController _widthController;
  late final TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    _lengthController = TextEditingController(text: widget.initialLength ?? '5');
    _widthController = TextEditingController(text: widget.initialWidth ?? '10');
    _heightController = TextEditingController(text: widget.initialHeight ?? '20');
  }

  @override
  void dispose() {
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _confirm() {
    final length = int.tryParse(_lengthController.text) ?? 0;
    final width = int.tryParse(_widthController.text) ?? 0;
    final height = int.tryParse(_heightController.text) ?? 0;
    widget.onConfirm(length, width, height);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyMedium.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _DimensionField(
                  label: 'الطول',
                  controller: _lengthController,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DimensionField(
                  label: 'العرض',
                  controller: _widthController,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DimensionField(
                  label: 'الارتفاع',
                  controller: _heightController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _confirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'تاكيد الطرد',
                style: AppStyles.styleSemiBold14(context).copyWith(
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

class _DimensionField extends StatelessWidget {
  const _DimensionField({
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppStyles.styleRegular12(context).copyWith(
          color: AppColors.greyDark,
        ),
        filled: true,
        fillColor: AppColors.greyLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
