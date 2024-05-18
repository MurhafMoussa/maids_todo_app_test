part of '../themes_data.dart';

ThemeData _getLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    unselectedWidgetColor: AppColors.gray5,
    disabledColor: AppColors.gray2,
    dividerTheme: const DividerThemeData(
      color: AppColors.gray3,
      thickness: 0.5,
    ),
    drawerTheme: DrawerThemeData(
      width: 280.w,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.primaryColorLight,
      dense: true,
      horizontalTitleGap: 8.w,
    ),
    scaffoldBackgroundColor: AppColors.gray6,
    iconButtonTheme: IconButtonThemeData(
      style: _buttonStyle.copyWith(
        visualDensity: const VisualDensity(
          horizontal: -4,
          vertical: -4,
        ),
        tapTargetSize: MaterialTapTargetSize.padded,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColorLight,
      secondary: AppColors.secondaryColorLight,
      onSecondary: AppColors.secondaryInnerColorLight,
      tertiary: AppColors.tertiaryColorLight,
      onTertiary: AppColors.tertiaryInnerColorLight,
      error: AppColors.errorText,
      errorContainer: AppColors.errorTextBackground,

      /// color for drawer and bottom navigation bar
      surfaceTint: AppColors.white,
      onSurface: AppColors.dark,
    ),
    dividerColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.gray6,
      titleSpacing: 8.w,
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    splashFactory: NoSplash.splashFactory,
    tabBarTheme: const TabBarTheme(
      tabAlignment: TabAlignment.start,
      indicatorSize: TabBarIndicatorSize.tab,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
    ),
    checkboxTheme: CheckboxThemeData(
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const BorderSide(
            color: AppColors.primaryColorLight,
            width: 0.5,
          );
        }

        return const BorderSide(
          color: AppColors.gray3,
          width: 0.5,
        );
      }),
      fillColor: const WidgetStatePropertyAll(AppColors.white),
      checkColor: const WidgetStatePropertyAll(AppColors.primaryColorLight),
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryColorLight;
        }
        return AppColors.gray3;
      }),
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 74.h,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: AppColors.secondaryColorLight,
          );
        }
        return const IconThemeData(
          color: AppColors.gray3,
        );
      }),
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      enabledBorder: _fieldBorder,
      disabledBorder: _fieldBorder,
      errorBorder: _fieldBorder,
      focusedBorder: _fieldBorder,
      focusedErrorBorder: _fieldBorder,
      alignLabelWithHint: true,
      floatingLabelStyle: TextThemeStyles.getTextStyle(
        FigmaFontStyle.subtitle1Medium,
        color: AppColors.gray2,
      ),
      labelStyle: TextThemeStyles.getTextStyle(
        FigmaFontStyle.h3Regular,
        color: AppColors.gray2,
      ),
      hintStyle: TextThemeStyles.getTextStyle(
        FigmaFontStyle.h3Regular,
        color: AppColors.gray2,
      ),
      iconColor: AppColors.dark,
      suffixIconColor: AppColors.dark,
      prefixIconColor: AppColors.dark,
      errorMaxLines: 2,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: TextTheme(
      displayLarge: TextThemeStyles.displayLarge,
      displayMedium: TextThemeStyles.displayMedium,
      displaySmall: TextThemeStyles.displaySmall,
      headlineMedium: TextThemeStyles.headlineMedium,
      headlineSmall: TextThemeStyles.headlineSmall,
      titleLarge: TextThemeStyles.titleLarge,
      titleMedium: TextThemeStyles.titleMedium,
      titleSmall: TextThemeStyles.titleSmall,
      bodyLarge: TextThemeStyles.bodyLarge,
      bodyMedium: TextThemeStyles.bodyMedium,
      bodySmall: TextThemeStyles.bodySmall,
      labelLarge: TextThemeStyles.labelLarge,
      labelSmall: TextThemeStyles.labelSmall,
    ).apply(
      displayColor: AppColors.dark,
      bodyColor: AppColors.dark,
    ),
    materialTapTargetSize: MaterialTapTargetSize.padded,
    filledButtonTheme: FilledButtonThemeData(
      style: _buttonStyle,
    ),
  );
}

UnderlineInputBorder get _fieldBorder {
  return UnderlineInputBorder(
    borderSide: const BorderSide(color: AppColors.gray3),
    borderRadius: BorderRadiusManager.radiusAll8,
  );
}

ButtonStyle get _buttonStyle {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.gray2;
        }
        return null;
      },
    ),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.radiusAll8,
      ),
    ),
    padding:
        WidgetStateProperty.all(PaddingManager.paddingHorizontal16Vertical12),
    textStyle: WidgetStateProperty.all<TextStyle>(TextThemeStyles.bodyLarge),
    foregroundColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.white;
        }
        return null;
      },
    ),
  );
}
