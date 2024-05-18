import 'package:flutter/material.dart';

/// This class used to add custom colors for dark and light mode.
@immutable
class CustomThemeColors extends ThemeExtension<CustomThemeColors> {

  const CustomThemeColors({
    required this.newBadge,
    required this.saleBadge,
  });
  final Color? newBadge;
  final Color? saleBadge;

  @override
  CustomThemeColors copyWith({
    Color? newBadge,
    Color? saleBadge,
  }) {
    return CustomThemeColors(
      newBadge: newBadge ?? this.newBadge,
      saleBadge: saleBadge ?? this.saleBadge,
    );
  }

  @override
  CustomThemeColors lerp(ThemeExtension<CustomThemeColors>? other, double t) {
    if (other is! CustomThemeColors) {
      return this;
    }

    return CustomThemeColors(
      newBadge: Color.lerp(newBadge, other.newBadge, t),
      saleBadge: Color.lerp(saleBadge, other.saleBadge, t),
    );
  }

  // Light theme
  static const CustomThemeColors light = CustomThemeColors(
    newBadge: Color(0xffF9A000),
    saleBadge: Color(0xffED1414),
  );

  // Dark theme
  static const CustomThemeColors dark = CustomThemeColors(
    newBadge: Color(0xffF9A000),
    saleBadge: Color(0xffED1414),
  );
}
