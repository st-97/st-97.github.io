import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/responsive/responsive_helper.dart';
import '../../layout/app_layout.dart';
import '../common/custom_button.dart';
import '../common/custom_card.dart';

/// Hero section with personal introduction
class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionLayout(
      backgroundColor: Colors.transparent,
      child: TwoColumnLayout(
        leftChild: _buildPersonalInfo(),
        rightChild: _buildProfileCard(),
        spacing: ResponsiveHelper.responsive(
          context,
          mobile: AppDimensions.paddingLarge,
          tablet: AppDimensions.paddingXLarge,
          desktop: AppDimensions.paddingXXLarge,
        ),
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Text(
              'Hello, I\'m',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSmall),
            
            // Name with gradient
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: AppColors.accentGradient,
              ).createShader(bounds),
              child: Text(
                AppStrings.name,
                style: AppTextStyles.displayLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingMedium),
            
            // Title
            Text(
              AppStrings.title,
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppDimensions.paddingLarge),
            
            // Description
            Text(
              AppStrings.aboutDescription,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
              maxLines: ResponsiveHelper.isMobile(context) ? 4 : null,
              overflow: ResponsiveHelper.isMobile(context) 
                  ? TextOverflow.ellipsis 
                  : null,
            ),
            SizedBox(height: AppDimensions.paddingXLarge),
            
            // Action buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Wrap(
      spacing: AppDimensions.paddingMedium,
      runSpacing: AppDimensions.paddingMedium,
      children: [
        CustomButton(
          text: AppStrings.getInTouch,
          type: ButtonType.primary,
          size: ButtonSize.large,
          icon: const Icon(
            Icons.message_outlined,
            color: AppColors.textPrimary,
            size: AppDimensions.iconMedium,
          ),
          onPressed: () {
            // Navigate to contact section
          },
        ),
        CustomButton(
          text: AppStrings.downloadCV,
          type: ButtonType.outline,
          size: ButtonSize.large,
          icon: const Icon(
            Icons.download_outlined,
            color: AppColors.accent,
            size: AppDimensions.iconMedium,
          ),
          onPressed: () {
            // Download CV functionality
          },
        ),
      ],
    );
  }

  Widget _buildProfileCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: CustomCard(
        padding: EdgeInsets.all(AppDimensions.paddingXLarge),
        child: Column(
          children: [
            // Profile image
            Container(
              width: ResponsiveHelper.responsive(
                context,
                mobile: 120.0,
                tablet: 150.0,
                desktop: 180.0,
              ),
              height: ResponsiveHelper.responsive(
                context,
                mobile: 120.0,
                tablet: 150.0,
                desktop: 180.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accent,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const CircleAvatar(
                backgroundColor: AppColors.surface,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: AppColors.accent,
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingLarge),
            
            // Online indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: AppDimensions.paddingSmall),
                Text(
                  'Available for work',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.paddingLarge),
            
            // Contact info
            _buildContactInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        _buildContactItem(
          Icons.email_outlined,
          'Email',
          AppStrings.email,
        ),
        SizedBox(height: AppDimensions.paddingMedium),
        _buildContactItem(
          Icons.phone_outlined,
          'Phone',
          AppStrings.phone,
        ),
        SizedBox(height: AppDimensions.paddingMedium),
        _buildContactItem(
          Icons.location_on_outlined,
          'Location',
          AppStrings.location,
        ),
        SizedBox(height: AppDimensions.paddingLarge),
        
        // Social links
        _buildSocialLinks(),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
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
                ),
              ),
              Text(
                value,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(Icons.link, AppColors.linkedin),
        SizedBox(width: AppDimensions.paddingMedium),
        _buildSocialIcon(Icons.code, AppColors.github),
        SizedBox(width: AppDimensions.paddingMedium),
        _buildSocialIcon(Icons.alternate_email, AppColors.twitter),
        SizedBox(width: AppDimensions.paddingMedium),
        _buildSocialIcon(Icons.email, AppColors.email),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: EdgeInsets.all(AppDimensions.paddingSmall),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
        child: Icon(
          icon,
          color: color,
          size: AppDimensions.iconSmall,
        ),
      ),
    );
  }
}
