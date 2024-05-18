import 'package:flutter/material.dart';

/// Centralizing application colors
class AppColors {
  AppColors._();

  // light theme colors
  /// Used in main components, such as buttons, some icons, tabs..
  static const Color primaryColorLight = Color(0xff0D76D7);
  static const Color primaryInnerColorLight = Color(0xffffffff);

  /// Used in complementary components, such as bottom bar buttons, favourite icon,
  /// Rocket buy button
  static const Color secondaryColorLight = Color(0xffEDB614);
  static const Color secondaryInnerColorLight = Color(0xffffffff);

  /// Used in complementary the cart button in the bottom bar + notification icon
  static const Color tertiaryColorLight = Color(0xffEB5757);
  static const Color tertiaryInnerColorLight = Color(0xffffffff);

  /// Used as onPrimary/onSecondary/onTertiary colors in case they were dark,
  /// as a default text color and as an unselected icon or text color

  static const Color dark = Color(0xff2B2B2B);
  static const Color errorText = Color(0xffd62929);
  static const Color errorTextBackground = Color.fromRGBO(214, 41, 41, .12);

  /// General Colors
  static const Color white = Color(0xffffffff);
  static const Color green = Color(0xff27AE60);
  static const Color yellow = Color(0xffF4BF23);
  static const Color red = Color(0xffEB5757);
  static const Color black = Color(0xff000000);

  /// this color is used for shadows mainly
  static const Color richBlack = Color(0xff040404);

  /// Gray Colors
  static const Color gray1 = Color(0xff5B5B5B);
  static const Color gray2 = Color(0xffACACAC);
  static const Color gray3 = Color(0xffC4C4C4);
  static const Color gray4 = Color(0xffE2E2E2);
  static const Color gray5 = Color(0xffF2F2F2);
  static const Color gray6 = Color(0xffFAFAFA);
  static const Color gray7 = Color(0xffE5E5E5);
  static const Color gray8 = Color(0XffEEEEEE);
}

/// To represent ratings in the review screen
final class RatingColors {
  static const Color excellent = Color(0xff4CAF50);
  static const Color good = Color(0xff6599FF);
  static const Color average = Color(0xffF1B505);
  static const Color poor = Color(0xffFBED1F);
  static const Color bad = Color(0xffED563E);
}
