import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/view_model/forget_password_view_model.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_state.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/widgets/pin_put_widget.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/widgets/resent_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyResetCodePage extends StatelessWidget {
  const VerifyResetCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordViewModel>();

    return BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
      builder: (context, state) {
        final bool isLoading = state.isLoading ?? false;
        final bool hasError = (state.error ?? "").isNotEmpty;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              Text(
                'emailVerification'.tr(),
                style: context.appTheme.semiBold18,
                textAlign: TextAlign.center,
              ),

              context.h(16),

              Text(
                'otpDescription'.tr(),
                textAlign: TextAlign.center,
                style: context.appTheme.regular14.copyWith(color: Colors.grey),
              ),

              context.h(48),

              PinPutWidget(
                hasError: hasError,
                isLoading: isLoading,
                cubit: cubit,
              ),
              context.h(10),
              if (hasError)
                Text(
                  'invalidCode'.tr(),
                  style: context.appTheme.regular12.copyWith(
                    color: context.appTheme.error,
                  ),

                  textAlign: TextAlign.right,
                ),

              context.h(40),

              const ResentEmail(),

              context.h(40),

              // Loading indicator
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }
}
