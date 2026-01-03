import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/constants/app_dimensions.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_intents.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_ui_events.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/view_model/forget_password_view_model.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/widgets/reset_password_page.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/widgets/send_reset_code_view.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/widgets/verify_reset_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late PageController _pageController;
  late TextEditingController _emailController;
  late TextEditingController _newPasswordController;
  late TextEditingController _newPasswordConfirmationController;
  late GlobalKey<FormState> _emailFormKey;
  late GlobalKey<FormState> _resetPasswordFormKey;

  @override
  void initState() {
    super.initState();
    _initControllers();

    context.read<ForgetPasswordViewModel>().uiEventsStream.listen((event) {
      switch (event) {
        case ForgetPasswordShowToastEvent():
          Toast.showToast(context, event.message, isError: event.isError);
        case NavigateToOTPEvent():
          _pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );

        case NavigateToChangePasswordEvent():
          _pageController.animateToPage(
            2,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );

        case NavigateToLoginEvent():
          Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _emailController.dispose();
    _newPasswordConfirmationController.dispose();
    _newPasswordController.dispose();
    _emailFormKey.currentState?.dispose();
    _resetPasswordFormKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        'password'.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ),
    body: Padding(
      padding: AppDimensions.pagePadding,
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _getPages.length,
        itemBuilder: (BuildContext context, int index) => _getPages[index],
      ),
    ),
  );

  List<Widget> get _getPages => [
    SendResetCodeView(
      onPressed: _confirmEmail,
      emailController: _emailController,
      formKey: _emailFormKey,
    ),
    const VerifyResetCodePage(),
    ResetPasswordPage(
      onPressed: _resetPassword,
      passwordController: _newPasswordController,
      confirmPasswordController: _newPasswordConfirmationController,
      formKey: _resetPasswordFormKey,
    ),
  ];

  void _confirmEmail() {
    if (_emailFormKey.currentState!.validate()) {
      context.read<ForgetPasswordViewModel>().doIntent(
        SendResetPasswordCodeIntent(_emailController.text),
      );
    }
  }

  void _resetPassword() {
    if (_resetPasswordFormKey.currentState!.validate()) {
      context.read<ForgetPasswordViewModel>().doIntent(
        ResetPasswordIntent(_emailController.text, _newPasswordController.text),
      );
    }
  }

  void _initControllers() {
    _pageController = PageController(initialPage: 0);

    _emailController = TextEditingController();
    _newPasswordConfirmationController = TextEditingController();
    _newPasswordController = TextEditingController();

    _emailFormKey = GlobalKey<FormState>();
    _resetPasswordFormKey = GlobalKey<FormState>();
  }
}
