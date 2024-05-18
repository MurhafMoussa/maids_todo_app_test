import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_todo_app_test/core/theme/font_weight_manager.dart';

/// Centralized the text styles that are used widely in app
class TextThemeStyles {
  /// for arabic font this value will be reduced by 1
  static double fontSizeDelta = 0.sp;
  static const TextOverflow _overFlow = TextOverflow.ellipsis;

  /// (112 + [fontSizeDelta])
  static final TextStyle displayLarge = TextStyle(
    fontSize: 112.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// (56 + [fontSizeDelta])
  static final TextStyle displayMedium = TextStyle(
    fontSize: 56.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// (45 + [fontSizeDelta])
  static final TextStyle displaySmall = TextStyle(
    fontSize: 45.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// (34 + [fontSizeDelta])
  static final TextStyle headlineMedium = TextStyle(
    fontSize: 34.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// (24 + [fontSizeDelta])
  static final TextStyle headlineSmall = TextStyle(
    fontSize: 24.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// (21 + [fontSizeDelta])
  static final TextStyle titleLarge = TextStyle(
    fontSize: 21.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// (20 + [fontSizeDelta])
  static final TextStyle titleMedium = TextStyle(
    fontSize: 20.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// (18 + [fontSizeDelta])
  static final TextStyle titleSmall = TextStyle(
    fontSize: 18.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// (16 + [fontSizeDelta])
  static final TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// (14 + [fontSizeDelta])
  static final TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// (12 + [fontSizeDelta])
  static final TextStyle bodySmall = TextStyle(
    fontSize: 12.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// (10 + [fontSizeDelta])
  static final TextStyle labelLarge = TextStyle(
    fontSize: 10.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// (8 + [fontSizeDelta])

  static final TextStyle labelSmall = TextStyle(
    fontSize: 8.sp + fontSizeDelta,
    overflow: _overFlow,
  );

  /// we don't use this function in the custom text , it is only used in specific
  /// cases where we need to provide a text style not a text widget
  static TextStyle getTextStyle(
    FigmaFontStyle style, {
    Color? color,
  }) {
    switch (style) {
      case FigmaFontStyle.subtitle3Regular:
        return labelSmall.copyWith(
          color: color,
          fontWeight: FontWeightManager.regular,
        );
      case FigmaFontStyle.subtitle2Regular:
        return labelLarge.copyWith(
          color: color,
          fontWeight: FontWeightManager.regular,
        );
      case FigmaFontStyle.subtitle1Regular:
        return bodySmall.copyWith(
          color: color,
          fontWeight: FontWeightManager.regular,
        );
      case FigmaFontStyle.h1Bold:
        return headlineSmall.copyWith(
          color: color,
          fontWeight: FontWeightManager.bold,
        );
      case FigmaFontStyle.h2Bold:
        return bodyLarge.copyWith(
          color: color,
          fontWeight: FontWeightManager.bold,
        );
      case FigmaFontStyle.h2Medium:
        return bodyLarge.copyWith(
          color: color,
          fontWeight: FontWeightManager.medium,
        );
      case FigmaFontStyle.h3Bold:
        return bodyMedium.copyWith(
          color: color,
          fontWeight: FontWeightManager.bold,
        );
      case FigmaFontStyle.h3Medium:
        return bodyMedium.copyWith(
          color: color,
          fontWeight: FontWeightManager.medium,
        );

      case FigmaFontStyle.h3Regular:
        return TextThemeStyles.bodyMedium.copyWith(
          color: color,
          fontWeight: FontWeightManager.regular,
        );
      case FigmaFontStyle.h2SemiBold:
        return TextThemeStyles.bodyLarge.copyWith(
          color: color,
          fontWeight: FontWeightManager.semiBold,
        );
      case FigmaFontStyle.h3MediumStrikeThrough:
        return TextThemeStyles.bodyMedium.copyWith(
          color: color,
          fontWeight: FontWeightManager.medium,
          decorationColor: color,
          decoration: TextDecoration.lineThrough,
        );
      case FigmaFontStyle.subtitle1BoldUnderLine:
        return TextThemeStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeightManager.bold,
          decorationColor: color,
          decoration: TextDecoration.underline,
        );
      case FigmaFontStyle.subtitle1Medium:
        return TextThemeStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeightManager.medium,
        );
      case FigmaFontStyle.subtitle1MediumUnderLine:
        return TextThemeStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeightManager.medium,
          decorationColor: color,
          decoration: TextDecoration.underline,
        );
      case FigmaFontStyle.subtitle1Bold:
        return TextThemeStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeightManager.bold,
        );
      case FigmaFontStyle.subtitle1RegularStrikeThrough:
        return TextThemeStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeightManager.regular,
          decorationColor: color,
          decoration: TextDecoration.lineThrough,
        );
      case FigmaFontStyle.subtitle2Bold:
        return TextThemeStyles.labelLarge.copyWith(
          color: color,
          fontWeight: FontWeightManager.bold,
        );
      case FigmaFontStyle.subtitle2Medium:
        return TextThemeStyles.labelLarge.copyWith(
          color: color,
          fontWeight: FontWeightManager.medium,
        );
      case FigmaFontStyle.subtitle3Bold:
        return TextThemeStyles.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeightManager.bold,
        );
      case FigmaFontStyle.h3MediumUnderline:
        return bodyMedium.copyWith(
          color: color,
          fontWeight: FontWeightManager.medium,
          decorationColor: color,
          decoration: TextDecoration.underline,
        );
      case FigmaFontStyle.h3BoldUnderline:
        return TextThemeStyles.bodyMedium.copyWith(
          color: color,
          fontWeight: FontWeightManager.bold,
          decorationColor: color,
          decoration: TextDecoration.underline,
        );
    }
  }
}

enum FigmaFontStyle {
  h3Regular,
  h2Medium,
  h2SemiBold,
  h2Bold,
  h3Bold,
  h3BoldUnderline,
  h1Bold,
  h3MediumStrikeThrough,
  h3Medium,
  h3MediumUnderline,
  subtitle1BoldUnderLine,
  subtitle1Medium,
  subtitle1MediumUnderLine,
  subtitle1Regular,

  subtitle1Bold,
  subtitle1RegularStrikeThrough,
  subtitle2Bold,
  subtitle2Medium,
  subtitle2Regular,
  subtitle3Bold,
  subtitle3Regular,
}
