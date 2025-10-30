import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/utils/others/app_color.dart';
import 'package:portfolio/utils/texts/app_text.dart';

class AppButton extends ElevatedButton {
  AppButton.bordered({
    super.key,
    String? label,
    Widget? prefixIcon,
    Widget? suffixIcon,
    List<Color>? borderGradientColors, // Gradient for the border
    List<Color>? backgroundGradientColors, // Gradient for the background
    Color labelColor = Colors.white,
    double? height,
    double? width,
    double? fontSize,
    VoidCallback? onTap,
    EdgeInsets? padding,
    double? borderWidth, // Border width for the gradient border
    Color? backgroundColor, // Static background color
    Color? defaultBorderColor, // Fallback border color
  }) : super(
          onPressed: onTap,
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets?>(padding),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.transparent, // Set to transparent for gradient
            ),
            overlayColor: MaterialStateProperty.all<Color>(
              Colors.black.withOpacity(0.1), // Ripple effect
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(width ?? double.infinity, height ?? 50),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
          child: Container(
            width: width?.w ?? double.infinity,
            height: height?.h ?? 50.h,
            decoration: BoxDecoration(
              gradient: borderGradientColors != null
                  ? LinearGradient(
                      colors: borderGradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [
                        AppColors.secondaryColor,
                        AppColors.primaryColor,
                      ], // Default gradient
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(16).r,
            ),
            padding: EdgeInsets.all(borderWidth ?? 2).r, // Border thickness
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15).r,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryBg,
                  borderRadius: BorderRadius.circular(16).r,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (prefixIcon != null) prefixIcon,
                    if (prefixIcon != null) SizedBox(width: 8.w),
                    if (label != null)
                      Text(
                        label,
                        style: TextStyle(
                          color: labelColor,
                          fontSize: fontSize ?? 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (suffixIcon != null) SizedBox(width: 8.w),
                    if (suffixIcon != null) suffixIcon,
                  ],
                ),
              ),
            ),
          ),
        );

  AppButton.primary({
    super.key,
    String? label,
    Widget? prefixIcon,
    Widget? suffixIcon,
    List<Color>? backgroundGradientColors, // Gradient for the button background
    Color? labelColor,
    double? height,
    double? width,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    AssetImage? backgroundImage,
    double? fontSize,
    VoidCallback? onTap,
    FontWeight? fontWeight,
    EdgeInsets? padding,
    Color? backgroundColor, // Static background color
  }) : super(
          onPressed: onTap,
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets?>(padding),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.transparent, // Set to transparent for gradient
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18).r,
              ),
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(width ?? double.infinity, height ?? 50.h),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
          child: Container(
            decoration: BoxDecoration(
                border: borderColor == null
                    ? null
                    : Border.all(color: borderColor, width: borderWidth ?? 1.0),
                gradient: backgroundColor == null
                    ? backgroundGradientColors == null
                        ? LinearGradient(
                            colors: AppColors.linearGradient.colors,
                            begin: Alignment(0.01, 1.00),
                            end: Alignment(0, -1),
                          )
                        : LinearGradient(
                            colors:
                                backgroundGradientColors, // Default gradient
                            begin: Alignment(0.00, 1.00),
                            end: Alignment(0, -1),
                          )
                    : null,
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius ?? 18).r,
                image: backgroundImage == null
                    ? null
                    : DecorationImage(image: backgroundImage)),
            alignment: Alignment.center,
            height: height ?? 50.h,
            width: width ?? double.infinity,
            //    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null) prefixIcon,
                if (prefixIcon != null) SizedBox(width: 8.w),
                AppText.subHeader(
                  text: label ?? '',
                  color: labelColor ?? Colors.white,
                  fontSize: fontSize ?? 16.sp,
                  fontWeight: fontWeight ?? FontWeight.bold,
                ),
                if (suffixIcon != null) SizedBox(width: 8.w),
                if (suffixIcon != null) suffixIcon,
              ],
            ),
          ),
        );

  AppButton.circle({
    super.key,
    Widget? icon,
    List<Color>? gradientColors, // Gradient for the background
    Color? backgroundColor,
    double? size,
    double? borderWidth,
    bool? showBorder,
    Color? borderColor,
    VoidCallback? onTap,
  }) : super(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Colors.transparent, // Set background to transparent
            shape: CircleBorder(),
            padding: EdgeInsets.all(0),
            minimumSize: Size(size ?? 40.h, size ?? 40.w),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: size ?? 40.w,
                height: size ?? 40.w,
                decoration: BoxDecoration(
                    gradient: backgroundColor == null
                        ? gradientColors != null
                            ? LinearGradient(
                                colors: gradientColors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  AppColors.secondaryColor,
                                  AppColors.primaryColor,
                                ], // Default gradient
                                begin: Alignment(0.00, 0.80),
                                end: Alignment(0, -1),
                              )
                        : null,
                    // color: gradientColors == null ? backgroundColor : null,
                    shape: BoxShape.circle,
                    border: showBorder == true
                        ? Border.all(
                            color: borderColor ?? Colors.transparent,
                            width: borderWidth ?? 2.5.r,
                          )
                        : null,
                    color: backgroundColor),
              ),
              if (icon != null) icon,
            ],
          ),
        );
  AppButton.loader({
    super.key,
    String? label,
    Widget? prefixIcon,
    Widget? suffixIcon,
    List<Color>? backgroundGradientColors, // Gradient for the button background
    Color? labelColor,
    double? height,
    double? width,
    double? fontSize,
    VoidCallback? onTap,
    EdgeInsets? padding,
    Color? backgroundColor, // Static background color
    required dynamic state, // To handle loader state
  }) : super(
          onPressed: onTap,
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets?>(padding),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.transparent, // Set to transparent for gradient
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18).r,
              ),
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(width ?? double.infinity, height ?? 50.h),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: backgroundColor == null
                  ? backgroundGradientColors == null
                      ? LinearGradient(
                          colors: AppColors
                              .linearGradient.colors, // Default gradient
                          begin: Alignment(0.00, 0.80),
                          end: Alignment(0, -1),
                        )
                      : LinearGradient(
                          colors: backgroundGradientColors, // Custom gradient
                          begin: Alignment(0.00, 1.00),
                          end: Alignment(0, -1),
                        )
                  : null,
              color: backgroundColor,
              borderRadius: BorderRadius.circular(18).r,
            ),
            alignment: Alignment.center,
            height: height ?? 50.h,
            width: width ?? double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
            child: state is LoaderState
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          labelColor ?? AppColors.whiteFFFFFF,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (prefixIcon != null) prefixIcon,
                      if (prefixIcon != null) SizedBox(width: 8.w),
                      AppText.subHeader(
                        text: label ?? '',
                        color: labelColor ?? Colors.white,
                        fontSize: fontSize ?? 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      if (suffixIcon != null) SizedBox(width: 8.w),
                      if (suffixIcon != null) suffixIcon,
                    ],
                  ),
          ),
        );
}

mixin LoaderState {}
