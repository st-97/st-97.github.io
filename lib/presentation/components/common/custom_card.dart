import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

/// Custom card component with consistent styling
class CustomCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final bool isHoverable;
  final Color? backgroundColor;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.onTap,
    this.isHoverable = true,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.border,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: AppDimensions.cardElevation,
      end: AppDimensions.cardElevation * 1.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool isHovered) {
    if (!widget.isHoverable) return;
    
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverChanged(true),
      onExit: (_) => _onHoverChanged(false),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.width,
              height: widget.height,
              margin: widget.margin,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? AppColors.surface,
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppDimensions.radiusLarge,
                ),
                border: widget.border,
                boxShadow: widget.boxShadow ?? _getDefaultBoxShadow(),
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppDimensions.radiusLarge,
                ),
                child: InkWell(
                  onTap: widget.onTap,
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? AppDimensions.radiusLarge,
                  ),
                  hoverColor: AppColors.hover.withOpacity(0.1),
                  child: Padding(
                    padding: widget.padding ?? EdgeInsets.all(AppDimensions.paddingLarge),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<BoxShadow> _getDefaultBoxShadow() {
    return [
      BoxShadow(
        color: AppColors.primaryDark.withOpacity(0.15),
        blurRadius: _elevationAnimation.value,
        offset: Offset(0, _elevationAnimation.value / 2),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: AppColors.primaryDark.withOpacity(0.1),
        blurRadius: _elevationAnimation.value * 2,
        offset: Offset(0, _elevationAnimation.value),
        spreadRadius: 0,
      ),
    ];
  }
}

/// Glass card with blur effect
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final double? borderRadius;
  final double opacity;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.onTap,
    this.borderRadius,
    this.opacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.textPrimary.withOpacity(opacity),
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppDimensions.radiusLarge,
        ),
        border: Border.all(
          color: AppColors.textPrimary.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppDimensions.radiusLarge,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimensions.radiusLarge,
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.all(AppDimensions.paddingLarge),
            child: child,
          ),
        ),
      ),
    );
  }
}
