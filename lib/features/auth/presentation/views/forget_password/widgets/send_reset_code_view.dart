import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/core/widgets/custom_text_form_field.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/view_model/forget_password_view_model.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class SendResetCodeView extends StatefulWidget {
  final void Function()? onPressed;
  final TextEditingController emailController;
  final GlobalKey<FormState>? formKey;

  const SendResetCodeView({
    super.key,
    this.onPressed,
    required this.emailController,
    this.formKey,
  });

  @override
  State<SendResetCodeView> createState() => _SendResetCodeViewState();
}

class _SendResetCodeViewState extends State<SendResetCodeView> {
  late Cubit<ForgetPasswordState> cubit;

  @override
  void initState() {
    cubit = context.read<ForgetPasswordViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Form(
      key: widget.formKey,
      child: BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
        builder: (context, state) {
          return Column(
            children: [
              context.h(40),
              Text(
                "forgetPassword".tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              context.h(16),
              Text(
                'enterEmailDescription'.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              context.h(32),
              CustomTextFormField(
                labelText: "Email".tr(),
                hintText: 'Enter your email'.tr(),
                controller: widget.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => AppValidator.validateEmail(value),
              ),
              context.h(48),
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
