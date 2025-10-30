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
    final isMobile = screenWidth < 768; // Match the ProfileSidebar breakpoint

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
        child: isMobile ? _buildMobileLayout(screenWidth) : _buildWebLayout(screenHeight),
      ),
    );
  }

  Widget _buildWebLayout(double screenHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // center row horizontally
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Fixed sidebar
        SizedBox(width: 200),
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
            child: Container(
              width: double.infinity, // limits content width
              alignment: Alignment.topLeft, // optional, center content
              child: const MainContentArea(isMobile: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(double screenWidth) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        children: [
          // Profile Sidebar - Dynamic height that adjusts to content
          Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: screenWidth > 600 ? 600 : double.infinity,
              minHeight: 250, // Minimum height
              maxHeight: 400, // Maximum height to prevent excessive growth
            ),
            child: const ProfileSidebar(),
          ),
          
          const SizedBox(height: AppDimensions.paddingLarge),
          
          // Main Content Area - Full width on mobile
          Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: screenWidth > 800 ? 800 : double.infinity,
            ),
            child: MainContentArea(isMobile: true),
          ),
        ],
      ),
    );
  }
}
