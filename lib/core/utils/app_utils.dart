import 'dart:async';
import 'package:flutter/material.dart';

/// Utility functions for common operations
class AppUtils {
  AppUtils._();

  /// Launch URL in browser
  static Future<void> launchURL(String url) async {
    // Will implement URL launcher logic
    debugPrint('Launching URL: $url');
  }

  /// Show snackbar
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Validate email
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Format phone number
  static String formatPhoneNumber(String phone) {
    // Basic phone number formatting
    return phone.replaceAllMapped(
      RegExp(r'(\d{3})(\d{3})(\d{4})'),
      (Match m) => '(${m[1]}) ${m[2]}-${m[3]}',
    );
  }

  /// Get file extension
  static String getFileExtension(String fileName) {
    return fileName.split('.').last.toLowerCase();
  }

  /// Convert string to title case
  static String toTitleCase(String text) {
    return text.toLowerCase().split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  /// Debounce function calls
  static Timer? _debounceTimer;
  static void debounce(Duration delay, VoidCallback callback) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, callback);
  }

  /// Get random color
  static Color getRandomColor() {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];
    return colors[DateTime.now().millisecondsSinceEpoch % colors.length];
  }
}
