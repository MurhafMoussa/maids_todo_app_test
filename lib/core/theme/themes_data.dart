import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maids_todo_app_test/core/theme/app_colors.dart';
import 'package:maids_todo_app_test/core/theme/text_theme_styles.dart';

part 'dark/dark_theme.dart';
part 'light/light_theme.dart';

class ThemesData {
  static ThemeData lightTheme() {
    return _getLightTheme();
  }

  static ThemeData darkTheme() {
    return _getDarkTheme();
  }
}
