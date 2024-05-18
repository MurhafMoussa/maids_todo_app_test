import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
}
