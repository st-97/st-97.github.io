import 'package:flutter/material.dart';

/// App color constants following modern design principles
class AppColors {
  AppColors._();

  // Primary colors - Dark theme based on the design
  static const Color primary = Color(0xFF2C2C2C);
  static const Color primaryLight = Color(0xFF383838);
  static const Color primaryDark = Color(0xFF1A1A1A);
  
  // Accent colors - Orange/Yellow accent from the design
  static const Color accent = Color(0xFFFFDB70);
  static const Color accentLight = Color(0xFFFFE599);
  static const Color accentDark = Color(0xFFE6C75A);
  
  // Background colors - Very dark theme
  static const Color background = Color(0xFF0F0F0F);
  static const Color surface = Color(0xFF1C1C1C);
  static const Color surfaceVariant = Color(0xFF252525);
  
  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF808080);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFE57373);
  static const Color info = Color(0xFF2196F3);
  
  // Interactive elements
  static const Color hover = Color(0xFF3A3A3A);
  static const Color pressed = Color(0xFF4A4A4A);
  static const Color disabled = Color(0xFF616161);
  
  // Gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFF2D2D2D),
    Color(0xFF1A1A1A),
  ];
  
  static const List<Color> accentGradient = [
    Color(0xFFFFA726),
    Color(0xFFFF7043),
  ];
  
  // Social media colors
  static const Color linkedin = Color(0xFF0077B5);
  static const Color github = Color(0xFF333333);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color email = Color(0xFFEA4335);
}
