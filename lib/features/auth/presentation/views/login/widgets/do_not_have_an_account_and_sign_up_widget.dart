import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DoNotHaveAnAccountAndSignUpWidget extends StatelessWidget {
  final void Function()? onTapSignUp;
  const DoNotHaveAnAccountAndSignUpWidget({super.key, this.onTapSignUp});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'doNotHaveAnAccount',
            style: context.appTheme.medium16.copyWith(color: Colors.black),
          ),
          const WidgetSpan(child: SizedBox(width: 6)),
          TextSpan(
            text: 'signUp',
            recognizer: TapGestureRecognizer()..onTap = onTapSignUp,
            style: context.appTheme.medium16.copyWith(
              color: context.appTheme.primary,
              decoration: TextDecoration.underline,
              decorationColor: context.appTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
