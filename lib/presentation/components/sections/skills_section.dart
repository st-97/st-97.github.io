import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/responsive/responsive_helper.dart';
import '../../../data/models/skill_model.dart';
import '../../layout/app_layout.dart';
import '../common/custom_card.dart';

/// Skills section with skill categories and progress indicators
class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with TickerProviderStateMixin {
  late AnimationController _titleAnimationController;
  late AnimationController _skillsAnimationController;
  late Animation<double> _titleFadeAnimation;
  late List<Animation<double>> _skillProgressAnimations;

  @override
  void initState() {
    super.initState();
    
    _titleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _skillsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _titleAnimationController,
        curve: Curves.easeOut,
      ),
    );

    // Progress animations for each skill
    _skillProgressAnimations = SkillModel.skills.map((skill) {
      return Tween<double>(begin: 0.0, end: skill.proficiency / 100.0).animate(
        CurvedAnimation(
          parent: _skillsAnimationController,
          curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
        ),
      );
    }).toList();

    // Start animations
    _titleAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _skillsAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _titleAnimationController.dispose();
    _skillsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionLayout(
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          _buildSectionHeader(),
          SizedBox(height: AppDimensions.paddingXXLarge),
          _buildSkillsContent(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return FadeTransition(
      opacity: _titleFadeAnimation,
      child: Column(
        children: [
          Text(
            AppStrings.skillsTitle,
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
    );
  }

  Widget _buildSkillsContent() {
    final categories = SkillModel.getCategories();
    
    return ResponsiveHelper.isDesktop(context)
        ? _buildDesktopLayout(categories)
        : _buildMobileLayout(categories);
  }

  Widget _buildDesktopLayout(List<String> categories) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Skills by category
        Expanded(
          flex: 2,
          child: _buildSkillsByCategory(categories),
        ),
        SizedBox(width: AppDimensions.paddingXXLarge),
        // Overall skills showcase
        Expanded(
          flex: 1,
          child: _buildSkillsShowcase(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(List<String> categories) {
    return Column(
      children: [
        _buildSkillsByCategory(categories),
        SizedBox(height: AppDimensions.paddingXXLarge),
        _buildSkillsShowcase(),
      ],
    );
  }

  Widget _buildSkillsByCategory(List<String> categories) {
    return Column(
      children: categories.map((category) {
        final categorySkills = SkillModel.getSkillsByCategory(category);
        return Padding(
          padding: EdgeInsets.only(bottom: AppDimensions.paddingXLarge),
          child: _SkillCategoryCard(
            category: category,
            skills: categorySkills,
            skillAnimations: _skillProgressAnimations,
            allSkills: SkillModel.skills,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSkillsShowcase() {
    return FadeTransition(
      opacity: _titleFadeAnimation,
      child: CustomCard(
        padding: EdgeInsets.all(AppDimensions.paddingXLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Technical Expertise',
              style: AppTextStyles.cardTitle,
            ),
            SizedBox(height: AppDimensions.paddingLarge),
            
            // Top skills with icons
            ...SkillModel.skills.take(6).map((skill) {
              final index = SkillModel.skills.indexOf(skill);
              return Padding(
                padding: EdgeInsets.only(bottom: AppDimensions.paddingMedium),
                child: AnimatedBuilder(
                  animation: _skillProgressAnimations[index],
                  builder: (context, child) {
                    return _SkillItem(
                      skill: skill,
                      progress: _skillProgressAnimations[index].value,
                    );
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

/// Skill category card widget
class _SkillCategoryCard extends StatelessWidget {
  final String category;
  final List<SkillModel> skills;
  final List<Animation<double>> skillAnimations;
  final List<SkillModel> allSkills;

  const _SkillCategoryCard({
    required this.category,
    required this.skills,
    required this.skillAnimations,
    required this.allSkills,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(AppDimensions.paddingXLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppDimensions.paddingSmall),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                ),
                child: Icon(
                  _getCategoryIcon(category),
                  color: AppColors.accent,
                  size: AppDimensions.iconMedium,
                ),
              ),
              SizedBox(width: AppDimensions.paddingMedium),
              Text(
                category,
                style: AppTextStyles.cardTitle,
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingLarge),
          
          // Skills grid
          Wrap(
            spacing: AppDimensions.paddingMedium,
            runSpacing: AppDimensions.paddingMedium,
            children: skills.map((skill) {
              final index = allSkills.indexOf(skill);
              return AnimatedBuilder(
                animation: skillAnimations[index],
                builder: (context, child) {
                  return _SkillChip(
                    skill: skill,
                    progress: skillAnimations[index].value,
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Mobile':
        return Icons.smartphone_outlined;
      case 'Web':
        return Icons.web_outlined;
      case 'Backend':
        return Icons.cloud_outlined;
      case 'Tools':
        return Icons.build_outlined;
      case 'Cloud':
        return Icons.cloud_queue_outlined;
      default:
        return Icons.code_outlined;
    }
  }
}

/// Individual skill chip
class _SkillChip extends StatefulWidget {
  final SkillModel skill;
  final double progress;

  const _SkillChip({
    required this.skill,
    required this.progress,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: _isHovered 
              ? AppColors.accent.withOpacity(0.2)
              : AppColors.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          border: Border.all(
            color: AppColors.accent.withOpacity(widget.progress),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Skill icon placeholder
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              ),
            ),
            SizedBox(width: AppDimensions.paddingSmall),
            Text(
              widget.skill.name,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (_isHovered) ...[
              SizedBox(width: AppDimensions.paddingSmall),
              Text(
                '${widget.skill.proficiency}%',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Skill item with progress bar
class _SkillItem extends StatelessWidget {
  final SkillModel skill;
  final double progress;

  const _SkillItem({
    required this.skill,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill.name,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.paddingSmall),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.accentGradient,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
