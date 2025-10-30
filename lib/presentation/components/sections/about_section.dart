import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/responsive/responsive_helper.dart';
import '../../../data/models/service_model.dart';
import '../../layout/app_layout.dart';
import '../common/custom_card.dart';

/// About section with services
class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with TickerProviderStateMixin {
  late AnimationController _titleAnimationController;
  late AnimationController _cardsAnimationController;
  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late List<Animation<double>> _cardAnimations;

  @override
  void initState() {
    super.initState();
    
    _titleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _cardsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _titleAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _titleAnimationController,
        curve: Curves.easeOut,
      ),
    );

    // Staggered animations for service cards
    _cardAnimations = List.generate(
      ServiceModel.services.length,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _cardsAnimationController,
          curve: Interval(
            index * 0.2,
            0.8 + (index * 0.1),
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    // Start animations
    _titleAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _cardsAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _titleAnimationController.dispose();
    _cardsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionLayout(
      backgroundColor: AppColors.surface.withOpacity(0.3),
      child: Column(
        children: [
          _buildSectionHeader(),
          SizedBox(height: AppDimensions.paddingXXLarge),
          _buildAboutContent(),
          SizedBox(height: AppDimensions.paddingXXLarge),
          _buildServicesGrid(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return FadeTransition(
      opacity: _titleFadeAnimation,
      child: SlideTransition(
        position: _titleSlideAnimation,
        child: Column(
          children: [
            Text(
              AppStrings.aboutTitle,
              style: AppTextStyles.sectionTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.paddingMedium),
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutContent() {
    return FadeTransition(
      opacity: _titleFadeAnimation,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          children: [
            Text(
              AppStrings.aboutDescription,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                height: 1.8,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.paddingLarge),
            Text(
              AppStrings.aboutCallToAction,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesGrid() {
    return Column(
      children: [
        FadeTransition(
          opacity: _titleFadeAnimation,
          child: Column(
            children: [
              SizedBox(height: AppDimensions.paddingXLarge),
              Text(
                AppStrings.whatImDoingTitle,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.paddingXLarge),
            ],
          ),
        ),
        CardGridLayout(
          crossAxisCount: ResponsiveHelper.responsive(
            context,
            mobile: 1,
            tablet: 2,
            desktop: 2,
            largeDesktop: 2,
          ),
          childAspectRatio: ResponsiveHelper.responsive(
            context,
            mobile: 1.2,
            tablet: 1.1,
            desktop: 1.3,
          ),
          children: ServiceModel.services.asMap().entries.map((entry) {
            final index = entry.key;
            final service = entry.value;
            return AnimatedBuilder(
              animation: _cardAnimations[index],
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    50 * (1 - _cardAnimations[index].value),
                  ),
                  child: Opacity(
                    opacity: _cardAnimations[index].value,
                    child: _ServiceCard(service: service),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// Individual service card widget
class _ServiceCard extends StatefulWidget {
  final ServiceModel service;

  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: CustomCard(
              padding: EdgeInsets.all(AppDimensions.paddingXLarge),
              backgroundColor: _isHovered 
                  ? AppColors.surface 
                  : AppColors.surfaceVariant.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service icon
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    child: Icon(
                      _getServiceIcon(widget.service.title),
                      color: AppColors.accent,
                      size: AppDimensions.iconLarge,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingLarge),
                  
                  // Service title
                  Text(
                    widget.service.title,
                    style: AppTextStyles.cardTitle,
                  ),
                  SizedBox(height: AppDimensions.paddingMedium),
                  
                  // Service description
                  Text(
                    widget.service.description,
                    style: AppTextStyles.cardSubtitle.copyWith(
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingLarge),
                  
                  // Technologies
                  Wrap(
                    spacing: AppDimensions.paddingSmall,
                    runSpacing: AppDimensions.paddingSmall,
                    children: widget.service.technologies.map((tech) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingMedium,
                          vertical: AppDimensions.paddingXSmall,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                          border: Border.all(
                            color: AppColors.accent.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          tech,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.accent,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  IconData _getServiceIcon(String title) {
    switch (title) {
      case 'Mobile Apps':
        return Icons.smartphone_outlined;
      case 'Web Development':
        return Icons.web_outlined;
      case 'UI/UX Design':
        return Icons.design_services_outlined;
      case 'Backend Development':
        return Icons.cloud_outlined;
      default:
        return Icons.code_outlined;
    }
  }
}
