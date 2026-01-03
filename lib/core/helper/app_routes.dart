import 'package:flower_app/core/app/presentation/view/app_section.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/view_model/forget_password_view_model.dart';
import 'package:flower_app/features/auth/presentation/views/login/view_model/login_view_model.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/forget_password_screen.dart';
import 'package:flower_app/features/auth/presentation/views/login/login_screen.dart';
import 'package:flower_app/features/auth/presentation/views/signup/signup_screen.dart';
import 'package:flower_app/features/auth/presentation/views/terms_and_conditions/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../di/di.dart';

class AppRoutes {
  static const String signup = '/signup';
  static const String login = '/login';
  static const String appSection = "appSection";
  static const String forgetPassword = "/forgetPassword";
  static const String terms = '/terms';
}

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.signup:
      return MaterialPageRoute(builder: (_) => const SignupScreen());
    case AppRoutes.appSection:
      return MaterialPageRoute(
        builder: (_) => BlocProvider<AppSectionViewModel>(
          create: (context) => AppSectionViewModel(),
          child: const AppSection(),
        ),
      );
    case AppRoutes.login:
      var cubit = getIt.get<LoginViewModel>();
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => cubit,
          child: const LoginScreen(),
        ),
      );
    case AppRoutes.terms:
      return MaterialPageRoute(builder: (_) => const TermsAndConditions());
    case AppRoutes.forgetPassword:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt.get<ForgetPasswordViewModel>(),
          child: const ForgetPasswordScreen(),
        ),
      );
    default:
      return null;
  }
}
