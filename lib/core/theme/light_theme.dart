import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flower_app/core/styles/app_text_styles.dart';
import 'package:flower_app/core/theme/app_theme.dart';
import 'package:flower_app/core/theme/theme_extension.dart';
import 'package:flutter/material.dart';

class LightTheme extends AppTheme {
  TabBarThemeData get tabBarThemeData => TabBarThemeData(
    labelColor: appThemeExtension.primary,
    unselectedLabelColor: Colors.grey,
    indicatorSize: TabBarIndicatorSize.label,
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    dividerColor: Colors.transparent,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: appThemeExtension.primary, width: 3),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      insets: const EdgeInsets.symmetric(vertical: 8),
    ),
    tabAlignment: TabAlignment.start,
  );

  @override
  BottomNavigationBarThemeData get bottomAppBarThemeData =>
      BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: appThemeExtension.regular12,
        selectedLabelStyle: appThemeExtension.regular12,
        selectedItemColor: color.primary,
        unselectedItemColor: color.secondary[80],
        backgroundColor: color.secondary,
      );

  @override
  AppColors get color => _LightColors();

  @override
  ThemeData get themeData => ThemeData(
    brightness: Brightness.light,

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(color.secondary),
      trackColor: WidgetStateProperty.all(color.primary),
    ),
    fontFamily: IAppText.fontFamily,
    useMaterial3: true,
    filledButtonTheme: filledButtonThemeData,
    inputDecorationTheme: inputDecorationTheme,
    elevatedButtonTheme: elevatedButtonThemeData,
    bottomNavigationBarTheme: bottomAppBarThemeData,
    scaffoldBackgroundColor: color.backgroundColor,
    outlinedButtonTheme: outlinedButtonThemeData,
    checkboxTheme: checkboxThemeData,
    extensions: [appThemeExtension],
    primarySwatch: materialColorWithStandardShades(color.primary),
    appBarTheme: appBarTheme,
    tabBarTheme: tabBarThemeData,
  );

  @override
  ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: color.surface[30],
          disabledForegroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          backgroundColor: color.primary,
          foregroundColor: color.secondary,
          textStyle: appThemeExtension.medium16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );

  @override
  OutlinedButtonThemeData get outlinedButtonThemeData =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          side: BorderSide(color: color.grey, width: 2),
          foregroundColor: color.grey,
          textStyle: appThemeExtension.medium16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );

  //TODO: add this line floatingLabelBehavior: FloatingLabelBehavior.always,
  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: color.grey),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: color.error),
    ),
    prefixIconColor: color.secondary[70],
    labelStyle: TextStyle(color: color.grey),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: color.grey),
    ),

    hintStyle: appThemeExtension.medium16.copyWith(color: color.secondary[70]),
  );

  @override
  CheckboxThemeData get checkboxThemeData => CheckboxThemeData(
    side: BorderSide(color: color.grey, width: 2),
    checkColor: WidgetStateProperty.all(color.secondary),
  );

  @override
  FilledButtonThemeData get filledButtonThemeData => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: color.primary,
      foregroundColor: color.secondary,
      textStyle: appThemeExtension.medium16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ),
  );

  @override
  AppThemeExtension get appThemeExtension => AppThemeExtension(
    semiBold24: AppTextStyles.semiBold24.copyWith(color: color.textColor),
    medium20: AppTextStyles.medium20.copyWith(color: color.textColor),
    semiBold18: AppTextStyles.semiBold18.copyWith(color: color.textColor),
    medium13: AppTextStyles.medium13.copyWith(color: color.textColor),
    medium16: AppTextStyles.medium16.copyWith(color: color.textColor),
    regular16: AppTextStyles.regular16.copyWith(color: color.textColor),
    regular14: AppTextStyles.regular14.copyWith(color: color.textColor),
    regular12: AppTextStyles.regular12.copyWith(color: color.textColor),
    semiBold12: AppTextStyles.semiBold12.copyWith(color: color.textColor),
    primary: color.primary,
    secondary: color.secondary,
    surface: color.surface,
    backgroundColor: color.backgroundColor,
    error: color.error,
    success: color.success,
    grey: color.grey,
    lightPink: color.lightPink,
    kDefaultRainbowColors: color.kDefaultRainbowColors,
  );

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    foregroundColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: const IconThemeData(size: 20, color: Colors.black),
    titleTextStyle: appThemeExtension.medium20,
    centerTitle: false,
  );
}

class _LightColors extends AppColors {
  @override
  Color get backgroundColor => Colors.white;

  @override
  Color get error => const Color(0xFFCC1010);

  @override
  MaterialColor get primary => const MaterialColor(0xFFD21E6A, <int, Color>{
    0: Color(0xFFD21E6A),
    10: Color(0xFFf6d2e1),
    20: Color(0xFFf0b4cd),
    30: Color(0xFFe98fb5),
    40: Color(0xFFe1699c),
    50: Color(0xFFda4483),
    60: Color(0xFFaf1958),
    70: Color(0xFF8c1447),
    80: Color(0xFF690f35),
    90: Color(0xFF460a23),
    100: Color(0xFF2a0615),
  });

  @override
  MaterialColor get secondary => const MaterialColor(0xFFf9f9f9, <int, Color>{
    0: Color(0xFFf9f9f9),
    10: Color(0xFFfefefe),
    20: Color(0xFFfdfdfd),
    30: Color(0xFFfcfcfc),
    40: Color(0xFFfbfbfb),
    50: Color(0xFFfafafa),
    60: Color(0xFFd0d0d0),
    70: Color(0xFFa6a6a6),
    80: Color(0xFF7D7D7D),
    90: Color(0xFF535353),
    100: Color(0xFF323232),
  });

  @override
  Color get success => const Color(0xFF0CB359);

  @override
  MaterialColor get surface => const MaterialColor(0xFF0c1015, <int, Color>{
    0: Color(0xFF0c1015),
    10: Color(0xFFcecfd0),
    20: Color(0xFFaeafb1),
    30: Color(0xFF86888a),
    40: Color(0xFF5d6063),
    50: Color(0xFF34383c),
    60: Color(0xFF0a0d12),
    70: Color(0xFF080b0e),
    80: Color(0xFF06080b),
    90: Color(0xFF040507),
    100: Color(0xFF020304),
  });

  @override
  Color get grey => const Color(0xFF535353);

  @override
  Color get lightPink => const Color(0xFFF9ECF0);

  @override
  Color get textColor => Colors.black;
  @override
  List<Color> get kDefaultRainbowColors => const [
    Color(0xFFf6d2e1),
    Color(0xFFf0b4cd),
    Color(0xFFe98fb5),
    Color(0xFFe1699c),
    Color(0xFFda4483),
    Color(0xFFaf1958),
    Color(0xFF8c1447),
  ];
}
