import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';

/// Custom elevated button with consistent styling
class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final Widget? icon;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.padding,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
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
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
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

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.isEnabled && !widget.isLoading;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: isEnabled ? _onTapDown : null,
        onTapUp: isEnabled ? _onTapUp : null,
        onTapCancel: isEnabled ? _onTapCancel : null,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.width,
                height: _getButtonHeight(),
                padding: widget.padding ?? _getButtonPadding(),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  border: _getBorder(),
                  boxShadow: _getBoxShadow(),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: isEnabled ? widget.onPressed : null,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                    child: Center(
                      child: widget.isLoading
                          ? _buildLoadingIndicator()
                          : _buildButtonContent(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.icon!,
          SizedBox(width: AppDimensions.paddingSmall),
          Text(
            widget.text,
            style: _getTextStyle(),
          ),
        ],
      );
    }

    return Text(
      widget.text,
      style: _getTextStyle(),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: _getIconSize(),
      height: _getIconSize(),
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
      ),
    );
  }

  double _getButtonHeight() {
    switch (widget.size) {
      case ButtonSize.small:
        return AppDimensions.buttonHeightSmall;
      case ButtonSize.medium:
        return AppDimensions.buttonHeightMedium;
      case ButtonSize.large:
        return AppDimensions.buttonHeightLarge;
    }
  }

  EdgeInsetsGeometry _getButtonPadding() {
    switch (widget.size) {
      case ButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        );
      case ButtonSize.medium:
        return EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
          vertical: AppDimensions.paddingMedium,
        );
      case ButtonSize.large:
        return EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXLarge,
          vertical: AppDimensions.paddingLarge,
        );
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ButtonSize.small:
        return AppDimensions.iconSmall;
      case ButtonSize.medium:
        return AppDimensions.iconMedium;
      case ButtonSize.large:
        return AppDimensions.iconLarge;
    }
  }

  Color _getBackgroundColor() {
    if (!widget.isEnabled) {
      return AppColors.disabled;
    }

    switch (widget.type) {
      case ButtonType.primary:
        return _isHovered ? AppColors.accentLight : AppColors.accent;
      case ButtonType.secondary:
        return _isHovered ? AppColors.hover : AppColors.surface;
      case ButtonType.outline:
        return _isHovered ? AppColors.accent.withOpacity(0.1) : Colors.transparent;
      case ButtonType.text:
        return _isHovered ? AppColors.hover : Colors.transparent;
    }
  }

  Color _getTextColor() {
    if (!widget.isEnabled) {
      return AppColors.textTertiary;
    }

    switch (widget.type) {
      case ButtonType.primary:
        return AppColors.textPrimary;
      case ButtonType.secondary:
        return AppColors.textPrimary;
      case ButtonType.outline:
        return AppColors.accent;
      case ButtonType.text:
        return AppColors.accent;
    }
  }

  TextStyle _getTextStyle() {
    TextStyle baseStyle;
    
    switch (widget.size) {
      case ButtonSize.small:
        baseStyle = AppTextStyles.labelMedium;
        break;
      case ButtonSize.medium:
        baseStyle = AppTextStyles.button;
        break;
      case ButtonSize.large:
        baseStyle = AppTextStyles.titleMedium;
        break;
    }

    return baseStyle.copyWith(color: _getTextColor());
  }

  Border? _getBorder() {
    if (widget.type == ButtonType.outline) {
      return Border.all(
        color: widget.isEnabled ? AppColors.accent : AppColors.disabled,
        width: 1.5,
      );
    }
    return null;
  }

  List<BoxShadow>? _getBoxShadow() {
    if (widget.type == ButtonType.primary && widget.isEnabled) {
      return [
        BoxShadow(
          color: AppColors.accent.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];
    }
    return null;
  }
}

/// Button types
enum ButtonType {
  primary,
  secondary,
  outline,
  text,
}

/// Button sizes
enum ButtonSize {
  small,
  medium,
  large,
}
