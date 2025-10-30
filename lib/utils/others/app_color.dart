import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const navy = Color(0xFF0C134F);
  static const blue = Color(0xFF1D267D);
  static const purple = Color(0xFF653EDB);
  static const lightPurple = Color(0xFFD4ADFC);

  static const orange = Color(0xFFE2870E);
  static const shadowColor = Color(0x1F757575);

  static const Color primaryorangeE2870E = Color(0xFFFBB335);
  static const Color primaryBg = Color(0xff120D21);
  static const Color primary271E42 = Color(0xff271E42);
  static const Color purple120D21 = Color(0Xff120D21);
  static const Color scaffoldBG = Color(0xff050014);
  static const Color color291F2D = Color(0xff291F2D);

  static const Color purple9C26E4 = Color(0xff9C26E4);
  static const Color pinkF14F76 = Color(0xffF14F76);
  static const Color green = Color(0xFFA7DE0A);

  static const Color grayF5F5F5 = Color(0xffF5F5F5);
  static const Color grayF6F6F6 = Color(0xffF6F6F6);
  static const Color grayF7F7F7 = Color(0xffF7F7F7);
  static const Color gray888D90 = Color(0xff888D90);
  static const Color gray5E5E5E = Color(0xff5E5E5E);
  static const Color gray717171 = Color(0xff717171);
  static const Color grayE9E9E9 = Color(0xffE9E9E9);
  static const Color grayE7E7E7 = Color(0xffE7E7E7);
  static const Color grayFCFCFC = Color(0xffFCFCFC);
  static const Color grayE3E3E3 = Color(0xffE3E3E3);
  static const Color gray757575 = Color(0xff757575);
  static const Color gray929292 = Color(0xff929292);
  static const Color gray939393 = Color(0xff939393);
  static const Color gray8A8A8F = Color(0xff8A8A8F);
  static const Color grayA7A9AC = Color(0xffA7A9AC);
  static const Color grayA9A8AA = Color(0xffA9A8AA);
  static const Color dark323232 = Color(0xff323232);
  static const Color dark565656 = Color(0xff565656);
  static const Color dark121212 = Color(0xff121212);
  static const Color dark1B1B1B = Color(0xff1B1B1B);
  static const Color dark000000 = Color(0xff000000);
  static const Color dark161616 = Color(0xff161616);
  static const Color dark17181C = Color(0xff17181C);
  static const Color dark131111 = Color(0xff131111);
  static const Color whiteFFFFFF = Color(0xffFFFFFF);
  static const Color blue47C1EE = Color(0xff47C1EE);
  static const Color dark202020 = Color(0xff202020);
  static const Color red = Color(0xffDD2F2F);
  static const Color logoutRed = Color(0xFFFF5757);

  static const Color redFF4444 = Color(0xffFF4444);
  static const Color redE05C5C = Color(0xffE05C5C);
  static const Color redEB434A = Color(0xffEB434A);
  static const Color redF5404B = Color(0xffF5404B);
  static const Color redFB4A3F = Color(0xffFB4A3F);
  static const Color transparent = Colors.transparent;
  static const Color greyC3C3C3 = Color(0xFFC3C3C3);
  static const Color greyEFEFEF = Color(0xFFEFEFEF);

  static const Color primaryColor = Color(0xffF6149B);
  static const Color secondaryColor = Color(0xff504BF9);
  static const Color color3AAA1E = Color(0xff3AAA1E);

  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color black1 = Color(0xff373737);
  static const Color black2 = Color(0xff8c8c8c);

  static const Color grey = Color(0xff6C757D);
  static const Color lightGrey = Color(0xffE9E9E9);

  static const Color darkYellow = Color(0xffC97608);

  // Gradients
  static LinearGradient linearGradient = LinearGradient(
    colors: [
      Color(0xFF5E46F1),
      Color(0xFFB32AC1),
    ], // Default gradient
    begin: Alignment(0.00, 0.80),
    end: Alignment(0, -1),
  );
  // Gradients
  static LinearGradient greenLiner = LinearGradient(
    colors: [
      AppColors.green,
      AppColors.green.withOpacity(0.4),
    ], // Default gradient
    begin: Alignment(0.00, 0.80),
    end: Alignment(0, -1),
  );
  static LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffB32AC1),
      Color(0xff5E46F1),
    ],
    stops: [
      0.1,
      1.0,
    ],
  );

  static const Color logoutRedColor = Color(0xffFF5757);
}
