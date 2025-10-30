import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// App typography system
class AppTextStyles {
  AppTextStyles._();

  // Base text style
  static TextStyle get _baseTextStyle => GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w400,
      );

  // Display styles
  static TextStyle get displayLarge => _baseTextStyle.copyWith(
        fontSize: 57.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        height: 1.12,
      );

  static TextStyle get displayMedium => _baseTextStyle.copyWith(
        fontSize: 45.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.16,
      );

  static TextStyle get displaySmall => _baseTextStyle.copyWith(
        fontSize: 36.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.22,
      );

  // Headline styles
  static TextStyle get headlineLarge => _baseTextStyle.copyWith(
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.25,
      );

  static TextStyle get headlineMedium => _baseTextStyle.copyWith(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.29,
      );

  static TextStyle get headlineSmall => _baseTextStyle.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.33,
      );

  // Title styles
  static TextStyle get titleLarge => _baseTextStyle.copyWith(
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.27,
      );

  static TextStyle get titleMedium => _baseTextStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.50,
      );

  static TextStyle get titleSmall => _baseTextStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      );

  // Label styles
  static TextStyle get labelLarge => _baseTextStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      );

  static TextStyle get labelMedium => _baseTextStyle.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
      );

  static TextStyle get labelSmall => _baseTextStyle.copyWith(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
      );

  // Body styles
  static TextStyle get bodyLarge => _baseTextStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.50,
      );

  static TextStyle get bodyMedium => _baseTextStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
      );

  static TextStyle get bodySmall => _baseTextStyle.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
      );

  // Custom styles for specific use cases
  static TextStyle get navItem => _baseTextStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.textSecondary,
      );

  static TextStyle get button => _baseTextStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: AppColors.textPrimary,
      );

  static TextStyle get caption => _baseTextStyle.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.textTertiary,
      );

  static TextStyle get overline => _baseTextStyle.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        color: AppColors.textTertiary,
      );

  // Brand specific styles
  static TextStyle get brandName => _baseTextStyle.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: AppColors.accent,
      );

  static TextStyle get sectionTitle => _baseTextStyle.copyWith(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: AppColors.textPrimary,
      );

  static TextStyle get cardTitle => _baseTextStyle.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  static TextStyle get cardSubtitle => _baseTextStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.textSecondary,
      );
}
