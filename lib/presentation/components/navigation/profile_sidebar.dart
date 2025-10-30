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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768; // Mobile breakpoint
    
    if (isMobile) {
      return _buildMobileView(context);
    } else {
      return _buildWebView();
    }
  }

  Widget _buildWebView() {
    return CustomCard(
      padding: const EdgeInsets.all(AppDimensions.paddingXXLarge),
      backgroundColor: AppColors.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Equal distribution
        crossAxisAlignment: CrossAxisAlignment.center, // Horizontal centering
        children: [
          // Profile Image with bigger styling
          Container(
            width: 160, // Increased from 140
            height: 160, // Increased from 140
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24), // Increased from 20
              border: Border.all(color: AppColors.surface, width: 10), // Increased from 8
              boxShadow: [
                BoxShadow(
                  color: AppColors.background.withOpacity(0.5),
                  blurRadius: 20, // Increased from 15
                  offset: const Offset(0, 8), // Increased from 5
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16), // Increased from 12
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(16), // Increased from 12
                ),
                child: const Icon(
                  Icons.person,
                  size: 80, // Increased from 70
                  color: AppColors.accent,
                ),
              ),
            ),
          ),
          
          // Online Status with centered positioning
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12, // Increased from 10
                  height: 12, // Increased from 10
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Available for work',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.success,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
            
            // Name with bigger text
            Text(
              AppStrings.name,
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700, // Increased from w600
                fontSize: 28, // Increased size
              ),
              textAlign: TextAlign.center,
            ),
            
            // Title with bigger text
            Text(
              AppStrings.title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                fontSize: 18, // Increased size
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            
            // Contact Info section
            Column(
              children: [
                _buildContactItem(
                  Icons.email_outlined,
                  'EMAIL',
                  AppStrings.email,
                ),
                const SizedBox(height: AppDimensions.paddingLarge),
                
                _buildContactItem(
                  Icons.phone_outlined,
                  'PHONE',
                  AppStrings.phone,
                ),
                const SizedBox(height: AppDimensions.paddingLarge),
                
                _buildContactItem(
                  Icons.location_on_outlined,
                  'LOCATION',
                  AppStrings.location,
                ),
              ],
            ),
             // Social Icons with better spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(Icons.facebook, AppColors.info),
                const SizedBox(width: AppDimensions.paddingLarge), // Increased spacing
                _buildSocialIcon(Icons.code, AppColors.textSecondary),
                const SizedBox(width: AppDimensions.paddingLarge), // Increased spacing
                _buildSocialIcon(Icons.alternate_email, AppColors.info),
                const SizedBox(width: AppDimensions.paddingLarge), // Increased spacing
                _buildSocialIcon(Icons.link, AppColors.textSecondary),
              ],
            ),
              
          ],
        ),
      );
  }

  Widget _buildMobileView(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      constraints: const BoxConstraints(
        minHeight: 380, // Minimum height
        maxHeight: 500, // Maximum height to prevent overflow
      ),
      child: IntrinsicHeight( // Auto-adjust height based on content
        child: Stack(
          children: [
            // Main card positioned lower to accommodate overlapping image
            Positioned(
              top: 90, // Increased from 40 to accommodate larger image (120px / 2)
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomCard(
                padding: const EdgeInsets.only(
                  top: 30, // Increased space for the larger overlapping image
                  left: AppDimensions.paddingLarge,
                  right: AppDimensions.paddingLarge,
                 // bottom: AppDimensions.paddingLarge, // Increased bottom padding
                ),
                backgroundColor: AppColors.surface,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center, // Ensure horizontal centering
                  mainAxisSize: MainAxisSize.min, // Allow content to determine size
                  children: [
                    // Name and Title Section - Centered
                    Column(
                      children: [
                        Text(
                          AppStrings.name,
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2, // Allow 2 lines for longer names
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6), // Slightly increased spacing
                        Text(
                          AppStrings.title,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2, // Allow 2 lines for longer titles
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    
                    // Expanded gap between designation and icons
                   // const SizedBox(height: AppDimensions.paddingXLarge), // Increased gap
                                        const SizedBox(height: 15), // Increased spacing

                    // Contact Info Row - All items start from same left position
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start, // Start from same left
                      children: [
                        _buildMobileContactIcon(Icons.email_outlined, AppStrings.email),
                        const SizedBox(height: 10), // Reduced from spaceEvenly
                        _buildMobileContactIcon(Icons.phone_outlined, AppStrings.phone),
                        const SizedBox(height: 10), // Reduced from spaceEvenly
                        _buildMobileContactIcon(Icons.location_on_outlined, AppStrings.location,),
                      ],
                    ),
                    
                    const SizedBox(height: 10), // Increased spacing
                    
                    // Social Icons Row - Tighter spacing, centered
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildMobileSocialIcon(Icons.facebook, AppColors.info),
                        const SizedBox(width: 25), // Reduced gap
                        _buildMobileSocialIcon(Icons.code, AppColors.textSecondary),
                        const SizedBox(width: 25), // Reduced gap
                        _buildMobileSocialIcon(Icons.alternate_email, AppColors.info),
                        const SizedBox(width: 25), // Reduced gap
                        _buildMobileSocialIcon(Icons.link, AppColors.textSecondary),
                      ],
                    ),
                                        const SizedBox(height: 15), // Increased spacing

                  ],
                ),
              ),
            ),
          
          // Overlapping Profile Image - Larger size, half above, half inside
          Positioned(
            top: 0, // Starts at the top
            left: screenWidth / 2 - 83, // Centered horizontally (60 = half of 120px width)
            child: Container(
              width: 120, // Increased from 80
              height: 120, // Increased from 80
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Increased from 16
                border: Border.all(color: AppColors.surface, width: 6), // Increased from 4
                boxShadow: [
                  BoxShadow(
                    color: AppColors.background.withOpacity(0.4),
                    blurRadius: 15, // Increased from 10
                    offset: const Offset(0, 6), // Increased from 4
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Increased from 12
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(15), // Increased from 12
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 60, // Increased from 40
                    color: AppColors.accent,
                  ),
                ),
              ),
            ),
          ),
          
          // Online Status Indicator - Adjusted for larger image
          Positioned(
            top: 105, // Adjusted for larger image
            left: screenWidth / 2 + 20, // Positioned next to larger profile image
            child: Container(
              width: 14, // Slightly larger
              height: 14, // Slightly larger
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 3), // Increased border
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium), // Increased padding
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium), // Increased radius
          ),
          child: Icon(
            icon,
            color: AppColors.accent,
            size: AppDimensions.iconMedium, // Increased from iconSmall
          ),
        ),
        const SizedBox(width: AppDimensions.paddingLarge), // Increased spacing
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                  fontSize: 12, // Increased from 10
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600, // Added font weight
                ),
              ),
              const SizedBox(height: 5), // Increased from 2
              Text(
                value,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12, // Increased from 12
                  fontWeight: FontWeight.w500, // Added font weight
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
      width: 40, // Increased from 32
      height: 40, // Increased from 32
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12), // Increased from 8
      ),
      child: Icon(
        icon,
        color: color,
        size: 20, // Increased from 16
      ),
    );
  }

  Widget _buildMobileContactIcon(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.max, // Use minimum space needed
      mainAxisAlignment: MainAxisAlignment.start, // Left align content within row
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.accent,
            size: 18,
          ),
        ),
        const SizedBox(width: 14),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildMobileSocialIcon(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: color,
        size: 25,
      ),
    );
  }
}
