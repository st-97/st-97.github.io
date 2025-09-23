import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/others/app_color.dart';

class AppFont {
  AppFont._();

  static TextStyle normal = GoogleFonts.poppins(fontWeight: FontWeight.normal);
  static TextStyle dancingScripNormal = GoogleFonts.dancingScript(
    fontSize: 15.sp,
    // fontFamily: fontFamily ?? 'Gilroy',
    fontWeight: FontWeight.normal,
    color: AppColors.black1,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,

    // overflow: TextOverflow.ellipsis, // Set overflow to ellipsis),

    //  TextStyle(
  );

  static TextStyle bold = GoogleFonts.poppins(fontWeight: FontWeight.bold);
}

extension AppFontSize on TextStyle {
  TextStyle get s12 {
    return copyWith(fontSize: 12.sp);
  }

  TextStyle get s14 {
    return copyWith(fontSize: 14.sp);
  }

  TextStyle get s16 {
    return copyWith(fontSize: 16.sp);
  }
}
