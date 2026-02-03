import 'package:flutter/widgets.dart';

abstract class AppDimensions {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 32.0;

  static const double buttonHeight = 16.0;

  static const double smallBorderRadius = 12.0;
  static const double mediumBorderRadius = 16.0;
  static const double largeBorderRadius = 24.0;

  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: AppPadding.medium,
    vertical: AppPadding.medium,
  );
}

abstract class AppPadding {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 32.0;

  static const EdgeInsets horizontalMedium = EdgeInsets.symmetric(
    horizontal: medium,
  );

  static const EdgeInsets verticalMedium = EdgeInsets.symmetric(
    vertical: medium,
  );
}
