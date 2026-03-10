import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_ezzy/core/utils/styles/Colors.dart';

abstract class AppStyles {
  // SemiBold styles
  static TextStyle styleSemiBold8(BuildContext context) =>
      _baseStyle(context, 8, FontWeight.w600);
  static TextStyle styleSemiBold10(BuildContext context) =>
      _baseStyle(context, 10, FontWeight.w600);
  static TextStyle styleSemiBold11(BuildContext context) =>
      _baseStyle(context, 11, FontWeight.w600);
  static TextStyle styleSemiBold12(BuildContext context) =>
      _baseStyle(context, 12, FontWeight.w600);
  static TextStyle styleSemiBold13(BuildContext context) =>
      _baseStyle(context, 13, FontWeight.w600);
  static TextStyle styleSemiBold14(BuildContext context) =>
      _baseStyle(context, 14, FontWeight.w600);
  static TextStyle styleSemiBold16(BuildContext context) =>
      _baseStyle(context, 16, FontWeight.w600);
  static TextStyle styleSemiBold18(BuildContext context) =>
      _baseStyle(context, 18, FontWeight.w600);
  static TextStyle styleSemiBold20(BuildContext context) =>
      _baseStyle(context, 20, FontWeight.w600);
  static TextStyle styleSemiBold24(BuildContext context) =>
      _baseStyle(context, 24, FontWeight.w600);
  static TextStyle styleSemiBold28(BuildContext context) =>
      _baseStyle(context, 28, FontWeight.w600);
  static TextStyle styleSemiBold32(BuildContext context) =>
      _baseStyle(context, 32, FontWeight.w600);
  static TextStyle styleSemiBold36(BuildContext context) =>
      _baseStyle(context, 36, FontWeight.w600);
  static TextStyle styleSemiBold40(BuildContext context) =>
      _baseStyle(context, 40, FontWeight.w600);

  // Regular styles
  static TextStyle styleRegular8(BuildContext context) =>
      _baseStyle(context, 8, FontWeight.w400);
  static TextStyle styleRegular10(BuildContext context) =>
      _baseStyle(context, 10, FontWeight.w400);
  static TextStyle styleRegular11(BuildContext context) =>
      _baseStyle(context, 11, FontWeight.w400);
  static TextStyle styleRegular12(BuildContext context) =>
      _baseStyle(context, 12, FontWeight.w400);
  static TextStyle styleRegular13(BuildContext context) =>
      _baseStyle(context, 13, FontWeight.w400);
  static TextStyle styleRegular14(BuildContext context) =>
      _baseStyle(context, 14, FontWeight.w400);
  static TextStyle styleRegular16(BuildContext context) =>
      _baseStyle(context, 16, FontWeight.w400);
  static TextStyle styleRegular18(BuildContext context) =>
      _baseStyle(context, 18, FontWeight.w400);
  static TextStyle styleRegular20(BuildContext context) =>
      _baseStyle(context, 20, FontWeight.w400);
  static TextStyle styleRegular24(BuildContext context) =>
      _baseStyle(context, 24, FontWeight.w400);
  static TextStyle styleRegular28(BuildContext context) =>
      _baseStyle(context, 28, FontWeight.w400);
  static TextStyle styleRegular32(BuildContext context) =>
      _baseStyle(context, 32, FontWeight.w400);
  static TextStyle styleRegular36(BuildContext context) =>
      _baseStyle(context, 36, FontWeight.w400);
  static TextStyle styleRegular40(BuildContext context) =>
      _baseStyle(context, 40, FontWeight.w400);

  // Bold styles
  static TextStyle styleBold8(BuildContext context) =>
      _baseStyle(context, 8, FontWeight.w700);
  static TextStyle styleBold10(BuildContext context) =>
      _baseStyle(context, 10, FontWeight.w700);
  static TextStyle styleBold11(BuildContext context) =>
      _baseStyle(context, 11, FontWeight.w700);
  static TextStyle styleBold12(BuildContext context) =>
      _baseStyle(context, 12, FontWeight.w700);
  static TextStyle styleBold13(BuildContext context) =>
      _baseStyle(context, 13, FontWeight.w700);
  static TextStyle styleBold14(BuildContext context) =>
      _baseStyle(context, 14, FontWeight.w700);
  static TextStyle styleBold16(BuildContext context) =>
      _baseStyle(context, 16, FontWeight.w700);
  static TextStyle styleBold18(BuildContext context) =>
      _baseStyle(context, 18, FontWeight.w700);
  static TextStyle styleBold20(BuildContext context) =>
      _baseStyle(context, 20, FontWeight.w700);
  static TextStyle styleBold24(BuildContext context) =>
      _baseStyle(context, 24, FontWeight.w700);
  static TextStyle styleBold28(BuildContext context) =>
      _baseStyle(context, 28, FontWeight.w700);
  static TextStyle styleBold32(BuildContext context) =>
      _baseStyle(context, 32, FontWeight.w700);
  static TextStyle styleBold36(BuildContext context) =>
      _baseStyle(context, 36, FontWeight.w700);
  static TextStyle styleBold40(BuildContext context) =>
      _baseStyle(context, 40, FontWeight.w700);

  // ExtraBold styles
  static TextStyle styleExtraBold8(BuildContext context) =>
      _baseStyle(context, 8, FontWeight.w800);
  static TextStyle styleExtraBold10(BuildContext context) =>
      _baseStyle(context, 10, FontWeight.w800);
  static TextStyle styleExtraBold11(BuildContext context) =>
      _baseStyle(context, 11, FontWeight.w800);
  static TextStyle styleExtraBold12(BuildContext context) =>
      _baseStyle(context, 12, FontWeight.w800);
  static TextStyle styleExtraBold13(BuildContext context) =>
      _baseStyle(context, 13, FontWeight.w800);
  static TextStyle styleExtraBold14(BuildContext context) =>
      _baseStyle(context, 14, FontWeight.w800);
  static TextStyle styleExtraBold16(BuildContext context) =>
      _baseStyle(context, 16, FontWeight.w800);
  static TextStyle styleExtraBold18(BuildContext context) =>
      _baseStyle(context, 18, FontWeight.w800);
  static TextStyle styleExtraBold20(BuildContext context) =>
      _baseStyle(context, 20, FontWeight.w800);
  static TextStyle styleExtraBold24(BuildContext context) =>
      _baseStyle(context, 24, FontWeight.w800);
  static TextStyle styleExtraBold28(BuildContext context) =>
      _baseStyle(context, 28, FontWeight.w800);
  static TextStyle styleExtraBold32(BuildContext context) =>
      _baseStyle(context, 32, FontWeight.w800);
  static TextStyle styleExtraBold36(BuildContext context) =>
      _baseStyle(context, 36, FontWeight.w800);
  static TextStyle styleExtraBold40(BuildContext context) =>
      _baseStyle(context, 40, FontWeight.w800);

  // Medium styles
  static TextStyle styleMedium8(BuildContext context) =>
      _baseStyle(context, 8, FontWeight.w500);
  static TextStyle styleMedium10(BuildContext context) =>
      _baseStyle(context, 10, FontWeight.w500);
  static TextStyle styleMedium11(BuildContext context) =>
      _baseStyle(context, 11, FontWeight.w500);
  static TextStyle styleMedium12(BuildContext context) =>
      _baseStyle(context, 12, FontWeight.w500);
  static TextStyle styleMedium13(BuildContext context) =>
      _baseStyle(context, 13, FontWeight.w500);
  static TextStyle styleMedium14(BuildContext context) =>
      _baseStyle(context, 14, FontWeight.w500);
  static TextStyle styleMedium16(BuildContext context) =>
      _baseStyle(context, 16, FontWeight.w500);
  static TextStyle styleMedium18(BuildContext context) =>
      _baseStyle(context, 18, FontWeight.w500);
  static TextStyle styleMedium20(BuildContext context) =>
      _baseStyle(context, 20, FontWeight.w500);
  static TextStyle styleMedium24(BuildContext context) =>
      _baseStyle(context, 24, FontWeight.w500);
  static TextStyle styleMedium28(BuildContext context) =>
      _baseStyle(context, 28, FontWeight.w500);
  static TextStyle styleMedium32(BuildContext context) =>
      _baseStyle(context, 32, FontWeight.w500);
  static TextStyle styleMedium36(BuildContext context) =>
      _baseStyle(context, 36, FontWeight.w500);
  static TextStyle styleMedium40(BuildContext context) =>
      _baseStyle(context, 40, FontWeight.w500);

  // Base style method
  static TextStyle _baseStyle(
    BuildContext context,
    double fontSize,
    FontWeight fontWeight,
  ) {
    return TextStyle(
      fontSize: _responsiveFontSize(context, fontSize),
      fontFamily: 'Cairo',
      color: Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.black,
      fontWeight: fontWeight,
    );
  }

  /// Adjust font size based on device type and width
  static double _responsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;

    if (kIsWeb || width > 800) {
      final scale = width / 1440; // Scale relative to desktop width
      if (baseSize >= 12.0) {
        return (baseSize * scale).clamp(12.0, baseSize.toDouble()).toDouble();
      } else {
        return (baseSize * scale).toDouble();
      }
    } else {
      return baseSize.sp;
    }
  }
}
