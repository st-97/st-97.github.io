import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';

/// Responsive helper class for different screen sizes
class ResponsiveHelper {
  ResponsiveHelper._();

  /// Check if the screen is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppDimensions.mobileBreakpoint;
  }

  /// Check if the screen is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppDimensions.mobileBreakpoint && 
           width < AppDimensions.desktopBreakpoint;
  }

  /// Check if the screen is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppDimensions.desktopBreakpoint;
  }

  /// Check if the screen is large desktop
  static bool isLargeDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppDimensions.largeDesktopBreakpoint;
  }

  /// Get responsive value based on screen size
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    if (isLargeDesktop(context) && largeDesktop != null) {
      return largeDesktop;
    }
    if (isDesktop(context) && desktop != null) {
      return desktop;
    }
    if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Get responsive padding
  static EdgeInsetsGeometry responsivePadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: responsive(
        context,
        mobile: AppDimensions.paddingMedium,
        tablet: AppDimensions.paddingLarge,
        desktop: AppDimensions.paddingXLarge,
        largeDesktop: AppDimensions.paddingXXLarge,
      ),
    );
  }

  /// Get responsive margin
  static EdgeInsetsGeometry responsiveMargin(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: responsive(
        context,
        mobile: AppDimensions.paddingSmall,
        tablet: AppDimensions.paddingMedium,
        desktop: AppDimensions.paddingLarge,
        largeDesktop: AppDimensions.paddingXLarge,
      ),
    );
  }

  /// Get responsive font size multiplier
  static double responsiveFontSize(BuildContext context) {
    return responsive(
      context,
      mobile: 0.9,
      tablet: 1.0,
      desktop: 1.1,
      largeDesktop: 1.2,
    );
  }

  /// Get responsive grid columns
  static int responsiveGridColumns(BuildContext context) {
    return responsive(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
      largeDesktop: 4,
    );
  }

  /// Get responsive card width
  static double responsiveCardWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return responsive(
      context,
      mobile: screenWidth * 0.9,
      tablet: screenWidth * 0.45,
      desktop: screenWidth * 0.3,
      largeDesktop: 350.0,
    );
  }
}

/// Responsive widget builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints constraints) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: builder);
  }
}
