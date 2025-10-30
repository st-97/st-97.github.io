import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/portfolio_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(1920, 1080), // Desktop-first design
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Shaikh Taha - Portfolio',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: const PortfolioPage(),
        );
      },
    );
  }
}
