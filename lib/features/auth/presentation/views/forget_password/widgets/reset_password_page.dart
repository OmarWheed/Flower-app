import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/core/widgets/custom_text_form_field.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/view_model/forget_password_view_model.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  final void Function() onPressed;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  const ResetPasswordPage({
    super.key,
    required this.onPressed,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late Cubit<ForgetPasswordState> cubit;

  @override
  void initState() {
    cubit = context.read<ForgetPasswordViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
          builder: (context, state) {
            return Column(
              children: [
                context.h(40),
                Text(
                  "resetPassword".tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                context.h(16),
                Text(
                  'resetPasswordDescription'.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
                context.h(48),
                CustomTextFormField(
                  labelText: "newPassword".tr(),
                  hintText: 'newPassword'.tr(),
                  controller: widget.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) => AppValidator.validatePassword(value),
                ),
                context.h(20),
                CustomTextFormField(
                  labelText: "confirmPassword".tr(),
                  hintText: 'confirmPassword'.tr(),
                  controller: widget.confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) => AppValidator.validateConfirmPassword(
                    value,
                    widget.passwordController.text,
                  ),
                ),
                context.h(30),
                state.isLoading == true
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: widget.onPressed,
                        child: Text('continue'.tr()),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
