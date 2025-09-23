import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../components/navigation/profile_sidebar.dart';
import '../components/sections/main_content_area.dart';class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // center row horizontally
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Fixed sidebar
            SizedBox(width: 200,),
            Container(
              width: 400,
              height: screenHeight,
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: const ProfileSidebar(),
            ),

            // Spacer between sidebar and main content
            const SizedBox(width: 40),

            // Scrollable main content (not full width)
          Flexible(
  child: SingleChildScrollView(
//    padding: const EdgeInsets.all(AppDimensions.paddingLarge),
    child: Container(
      //color: AppColors.c,
      width: double.infinity, // limits content width
       alignment: Alignment.topLeft, // optional, center content
      child: const MainContentArea(),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}
