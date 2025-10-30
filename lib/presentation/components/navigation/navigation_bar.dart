import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/responsive/responsive_helper.dart';

/// Modern navigation bar component
class NavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final bool isScrolled;

  const NavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    this.isScrolled = false,
  });

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  static const List<NavigationItem> _navigationItems = [
    NavigationItem(title: AppStrings.about, index: 0),
    NavigationItem(title: AppStrings.resume, index: 1),
    NavigationItem(title: AppStrings.portfolio, index: 2),
    NavigationItem(title: AppStrings.blog, index: 3),
    NavigationItem(title: AppStrings.contact, index: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: AppDimensions.navBarHeight,
        decoration: BoxDecoration(
          color: widget.isScrolled
              ? AppColors.surface.withOpacity(0.95)
              : Colors.transparent,
          boxShadow: widget.isScrolled
              ? [
                  BoxShadow(
                    color: AppColors.primaryDark.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: ResponsiveHelper.isDesktop(context)
            ? _buildDesktopNavigation()
            : _buildMobileNavigation(),
      ),
    );
  }

  Widget _buildDesktopNavigation() {
    return Padding(
      padding: ResponsiveHelper.responsivePadding(context),
      child: Row(
        children: [
          // Logo
          _buildLogo(),
          const Spacer(),
          // Navigation items
          ..._navigationItems.map((item) => _buildNavigationItem(item)),
          SizedBox(width: AppDimensions.paddingLarge),
          // CTA Button
          _buildCTAButton(),
        ],
      ),
    );
  }

  Widget _buildMobileNavigation() {
    return Padding(
      padding: ResponsiveHelper.responsivePadding(context),
      child: Row(
        children: [
          _buildLogo(),
          const Spacer(),
          _buildMobileMenuButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: () => widget.onItemSelected(0),
      child: Text(
        'Portfolio',
        style: AppTextStyles.brandName,
      ),
    );
  }

  Widget _buildNavigationItem(NavigationItem item) {
    final isSelected = widget.selectedIndex == item.index;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingSmall),
      child: _NavigationItemWidget(
        title: item.title,
        isSelected: isSelected,
        onTap: () => widget.onItemSelected(item.index),
      ),
    );
  }

  Widget _buildCTAButton() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
        vertical: AppDimensions.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        AppStrings.getInTouch,
        style: AppTextStyles.button.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return IconButton(
      onPressed: () => _showMobileMenu(),
      icon: const Icon(
        Icons.menu,
        color: AppColors.textPrimary,
      ),
    );
  }

  void _showMobileMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      builder: (context) => _MobileMenuSheet(
        selectedIndex: widget.selectedIndex,
        onItemSelected: (index) {
          Navigator.pop(context);
          widget.onItemSelected(index);
        },
      ),
    );
  }
}

/// Navigation item data class
class NavigationItem {
  final String title;
  final int index;

  const NavigationItem({
    required this.title,
    required this.index,
  });
}

/// Individual navigation item widget
class _NavigationItemWidget extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavigationItemWidget({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavigationItemWidget> createState() => _NavigationItemWidgetState();
}

class _NavigationItemWidgetState extends State<_NavigationItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverChanged(true),
      onExit: (_) => _onHoverChanged(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium,
                  vertical: AppDimensions.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: widget.isSelected || _isHovered
                      ? AppColors.accent.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                ),
                child: Text(
                  widget.title,
                  style: AppTextStyles.navItem.copyWith(
                    color: widget.isSelected ? AppColors.accent : AppColors.textSecondary,
                    fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onHoverChanged(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}

/// Mobile menu sheet
class _MobileMenuSheet extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const _MobileMenuSheet({
    required this.selectedIndex,
    required this.onItemSelected,
  });

  static const List<NavigationItem> _navigationItems = [
    NavigationItem(title: AppStrings.about, index: 0),
    NavigationItem(title: AppStrings.resume, index: 1),
    NavigationItem(title: AppStrings.portfolio, index: 2),
    NavigationItem(title: AppStrings.blog, index: 3),
    NavigationItem(title: AppStrings.contact, index: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textTertiary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: AppDimensions.paddingLarge),
          // Menu items
          ..._navigationItems.map((item) => _buildMobileMenuItem(item)),
          SizedBox(height: AppDimensions.paddingLarge),
          // CTA Button
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppDimensions.paddingMedium),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: Text(
              AppStrings.getInTouch,
              textAlign: TextAlign.center,
              style: AppTextStyles.button.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileMenuItem(NavigationItem item) {
    final isSelected = selectedIndex == item.index;
    
    return InkWell(
      onTap: () => onItemSelected(item.index),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppDimensions.paddingMedium),
        margin: EdgeInsets.only(bottom: AppDimensions.paddingSmall),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
        child: Text(
          item.title,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected ? AppColors.accent : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
