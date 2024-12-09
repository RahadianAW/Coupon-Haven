// lib/utils/constants.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const primary = Color(0xFF3498DB);
  static const background = Colors.white;
  static const cardBackground = Colors.white;
  
  // Text Colors
  static const textPrimary = Color(0xFF2B2B2B);
  static const textSecondary = Color(0xFF6B6B6B);
  
  // Other Colors
  static const footerBackground = Color(0xFF1E1E1E);
  static const dividerColor = Color(0xFFEEEEEE);
}

class AppTheme {
  static TextStyle get heading1 => const TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get heading2 => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get subtitle1 => const TextStyle(
    fontSize: 18,
    color: AppColors.textSecondary,
    letterSpacing: 0.15,
  );

  static TextStyle get body1 => const TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static BoxDecoration get cardDecoration => BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

class AppAnimations {
  static Duration get fast => const Duration(milliseconds: 200);
  static Duration get medium => const Duration(milliseconds: 400);
  static Duration get slow => const Duration(milliseconds: 800);
}