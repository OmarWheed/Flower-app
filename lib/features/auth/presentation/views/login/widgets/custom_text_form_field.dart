import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final String? label;
  final TextInputAction? textInputAction;
  final double? borderRadius;
  final BorderSide? borderSide;
  final OutlineInputBorder? outlineInputBorder;
  final Widget? suffixIcon;
  final bool? isObscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;

  const CustomTextFromField({
    super.key,
    required this.hintText,
    this.hintStyle,
    this.borderRadius,
    this.borderSide,
    this.outlineInputBorder,
    this.suffixIcon,
    this.isObscureText,
    required this.label,
    this.controller,
    this.validator, this.textInputAction, this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      validator: validator,
      obscureText: isObscureText ?? false,

      decoration: InputDecoration(
        isDense: true,
        suffixIcon: suffixIcon,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText:hintText,
        hintStyle: hintStyle ?? context.appTheme.regular14,
      ),
    );
  }
}
