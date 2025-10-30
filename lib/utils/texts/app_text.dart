import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/others/app_color.dart';
import 'package:portfolio/utils/others/app_font.dart';

class AppText extends Text {
  AppText.subHeader({
    String? text,
    TextStyle? custom,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
    Color? color,
    double? letterSpacing,
    double? height,
    int? maxLines,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    TextOverflow? overflow,
  })  : assert(text != null, "Text must not be null"),
        super(
          text!,
          overflow: overflow ?? TextOverflow.visible,
          textAlign: textAlign ?? TextAlign.start,
          style: custom ??
              AppFont.normal.copyWith(
                fontSize: fontSize ?? 15.sp,
                // fontFamily: fontFamily ?? 'Gilroy',
                fontWeight: fontWeight ?? FontWeight.normal,
                color: color ?? AppColors.black1,
                fontStyle: fontStyle ?? FontStyle.normal,
                letterSpacing: letterSpacing ?? 0,
                height: height,
                decoration: decoration,
                decorationColor: decorationColor,
                // overflow: TextOverflow.ellipsis, // Set overflow to ellipsis),

                //  TextStyle(
              ),
          //   maxLines: maxLines, // Set maxLines to control overflow
        );
}
