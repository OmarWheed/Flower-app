import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_intents.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/view_model/forget_password_view_model.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResentEmail extends StatelessWidget {
  const ResentEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
      builder: (context, state) {
        final bool isLoading = state.isLoading ?? false;
        final int remaining = state.resendRemainingSeconds;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("didn'tReceiveCode".tr()),
            context.w(8),
            remaining > 0
                ? Row(
                    children: [
                      Text(
                        'resendIn'.tr(args: [remaining.toString()]),
                        style: TextStyle(
                          color: context.appTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' 00:$remaining',
                        style: TextStyle(
                          color: context.appTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : GestureDetector(
                    onTap: isLoading
                        ? null
                        : () {
                            final savedEmail = context
                                .read<ForgetPasswordViewModel>()
                                .savedEmail;
                            if (savedEmail != null && savedEmail.isNotEmpty) {
                              context.read<ForgetPasswordViewModel>().doIntent(
                                SendResetPasswordCodeIntent(savedEmail),
                              );
                            }
                          },
                    child: Text(
                      'resend'.tr(),
                      style: TextStyle(
                        color: isLoading
                            ? Colors.grey
                            : context.appTheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
