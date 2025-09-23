import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/service_model.dart';
import '../common/custom_card.dart';

/// Main content area matching the exact design
class MainContentArea extends StatelessWidget {
  const MainContentArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000.w,
       margin: const EdgeInsets.only(
        left: 0, // No left padding as requested
        top: AppDimensions.paddingLarge,
       right: AppDimensions.paddingLarge,
        bottom: AppDimensions.paddingLarge,
      ),
        decoration: BoxDecoration(
          color: AppColors.disabled,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDark.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingXXLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Navigation Pills
              _buildNavigationPills(),
              const SizedBox(height: AppDimensions.paddingXXLarge),
              
              // About Me Section
              _buildAboutSection(),
              const SizedBox(height: AppDimensions.paddingXXLarge),
              
              // What I'm Doing Section
              _buildWhatImDoingSection(),
              const SizedBox(height: AppDimensions.paddingXXLarge),
              
              // Skills Section
              _buildSkillsSection(),
            ],
          ),
        ),
      );
  }

  Widget _buildNavigationPills() {
    final items = ['About', 'Resume', 'Portfolio', 'Blog', 'Contact'];
    return Row(
      children: items.map((item) {
        final isActive = item == 'About';
        return Container(
          margin: const EdgeInsets.only(right: AppDimensions.paddingLarge),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge,
            vertical: AppDimensions.paddingMedium,
          ),
          decoration: BoxDecoration(
            color: isActive ? AppColors.accent : Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
          child: Text(
            item,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isActive ? AppColors.background : AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with underline
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Me',
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Container(
              width: 40,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingXLarge),
        
        // Description
        Text(
          AppStrings.aboutDescription,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        
        Text(
          AppStrings.aboutCallToAction,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildWhatImDoingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What I'm Doing",
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingXLarge),
        
        // Service Cards Grid - Always use row layout for desktop look
        Row(
          children: [
            Expanded(child: _buildServiceCard(ServiceModel.services[0])),
            const SizedBox(width: AppDimensions.paddingLarge),
            Expanded(child: _buildServiceCard(ServiceModel.services[1])),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        
        Row(
          children: [
            Expanded(child: _buildServiceCard(ServiceModel.services[2])),
            const SizedBox(width: AppDimensions.paddingLarge),
            Expanded(child: _buildServiceCard(ServiceModel.services[3])),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCard(ServiceModel service) {
    return CustomCard(
      padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
      backgroundColor: AppColors.surfaceVariant,
      child: Row(
        children: [
          // Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: Icon(
              _getServiceIcon(service.title),
              color: AppColors.accent,
              size: AppDimensions.iconLarge,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingLarge),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingSmall),
                Text(
                  service.description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingXLarge),
        
        // Skills Icons Row
        Row(
          children: [
            _buildSkillIcon('Flutter', AppColors.info),
            const SizedBox(width: AppDimensions.paddingLarge),
            _buildSkillIcon('Firebase', AppColors.accent),
            const SizedBox(width: AppDimensions.paddingLarge),
            _buildSkillIcon('Node.js', AppColors.success),
            const SizedBox(width: AppDimensions.paddingLarge),
            _buildSkillIcon('Design', AppColors.error),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        
        // Progress bar (decorative)
        Container(
          width: double.infinity,
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.7,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillIcon(String skill, Color color) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getSkillIcon(skill),
            color: color,
            size: 32,
          ),
          const SizedBox(height: 4),
          Text(
            skill,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getServiceIcon(String title) {
    switch (title) {
      case 'Mobile Apps':
        return Icons.smartphone_outlined;
      case 'Web Development':
        return Icons.monitor_outlined;
      case 'UI/UX Design':
        return Icons.design_services_outlined;
      case 'Backend Development':
        return Icons.storage_outlined;
      default:
        return Icons.code_outlined;
    }
  }

  IconData _getSkillIcon(String skill) {
    switch (skill) {
      case 'Flutter':
        return Icons.flutter_dash;
      case 'Firebase':
        return Icons.whatshot;
      case 'Node.js':
        return Icons.code;
      case 'Design':
        return Icons.palette;
      default:
        return Icons.star;
    }
  }
}
