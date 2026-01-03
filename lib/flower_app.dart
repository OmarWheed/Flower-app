import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/main.dart';
import 'package:flutter/material.dart';

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    log("validation.enterUsername".tr());
    return MaterialApp(
      title: 'Flower App',
      debugShowCheckedModeBanner: false,
      theme: LightTheme().themeData,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: isLoggedInUser ? AppRoutes.appSection : AppRoutes.login,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
