import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import '../common/custom_card.dart';

/// Left sidebar profile card - matches the design exactly
class ProfileSidebar extends StatelessWidget {
  const ProfileSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(AppDimensions.paddingXXLarge),
      backgroundColor: AppColors.surface,
      child: Column(
        children: [
          // Profile Image with exact styling
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.surface, width: 8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.background.withOpacity(0.5),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person,
                  size: 70,
                  color: AppColors.accent,
                ),
              ),
            ),
          ),
          SizedBox(height: AppDimensions.paddingLarge),
          
          // Online Status with exact positioning
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingXLarge),
            
            // Name
            Text(
              AppStrings.name,
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.paddingSmall),
            
            // Title
            Text(
              AppStrings.title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.paddingXLarge),
            
            // Contact Info
            _buildContactItem(
              Icons.email_outlined,
              'EMAIL',
              AppStrings.email,
            ),
            SizedBox(height: AppDimensions.paddingLarge),
            
            _buildContactItem(
              Icons.phone_outlined,
              'PHONE',
              AppStrings.phone,
            ),
            SizedBox(height: AppDimensions.paddingLarge),
            
            _buildContactItem(
              Icons.location_on_outlined,
              'LOCATION',
              AppStrings.location,
            ),
            SizedBox(height: AppDimensions.paddingXLarge),
            
            // Social Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(Icons.facebook, AppColors.info),
                SizedBox(width: AppDimensions.paddingMedium),
                _buildSocialIcon(Icons.code, AppColors.textSecondary),
                SizedBox(width: AppDimensions.paddingMedium),
                _buildSocialIcon(Icons.alternate_email, AppColors.info),
                SizedBox(width: AppDimensions.paddingMedium),
                _buildSocialIcon(Icons.link, AppColors.textSecondary),
              ],
            ),
          ],
        ),
      );
    
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(AppDimensions.paddingSmall),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
          child: Icon(
            icon,
            color: AppColors.accent,
            size: AppDimensions.iconSmall,
          ),
        ),
        SizedBox(width: AppDimensions.paddingMedium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                  fontSize: 10,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: color,
        size: 16,
      ),
    );
  }
}
