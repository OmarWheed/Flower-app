import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/auth/presentation/views/signup/managers/signup_view_event.dart';
import 'package:flower_app/features/auth/presentation/views/signup/managers/signup_view_intent.dart';
import 'package:flower_app/features/auth/presentation/views/signup/managers/signup_view_states.dart';
import 'package:flower_app/features/auth/presentation/views/signup/view_model/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupViewModel signUpViewModel = getIt<SignupViewModel>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    signUpViewModel.signupUiEvent.listen((event) {
      switch (event) {
        case SignupShowToast():
          Toast.showToast(context, event.message, isError: event.isError);

        case SignupNavigateToLogin():
          Navigator.pop(context);

        case SignupNavigateToTermsConditions():
          Navigator.pushNamed(context, AppRoutes.terms);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupViewModel>(
      create: (context) => signUpViewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up", style: context.appTheme.medium20).tr(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "First name".tr(),
                              hintText: "Enter First name".tr(),
                            ),

                            controller: firstNameController,
                            validator: AppValidator.validateFirstName,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Last name".tr(),
                              hintText: "Enter last name".tr(),
                            ),
                            controller: lastNameController,
                            validator: AppValidator.validateLastName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email".tr(),
                        hintText: "Enter your email".tr(),
                      ),

                      controller: emailController,
                      validator: AppValidator.validateEmail,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password".tr(),
                              hintText: "Enter Password".tr(),
                            ),

                            controller: passwordController,
                            validator: AppValidator.validatePassword,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Confirm password".tr(),
                              hintText: "Confirm password".tr(),
                            ),

                            validator: (value) =>
                                AppValidator.validateConfirmPassword(
                                  passwordController.text,
                                  value!,
                                ),
                            controller: confirmPasswordController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Phone number".tr(),
                        hintText: "Enter Phone number".tr(),
                      ),

                      controller: phoneController,
                      validator: AppValidator.validatePhone,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: BlocBuilder<SignupViewModel, SignupStates>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  Text(
                                    "Gender".tr(),
                                    style: context.appTheme.medium16,
                                  ),
                                  Expanded(
                                    child: RadioListTile<String>(
                                      title: Text(
                                        "male".tr(),
                                        style: context.appTheme.regular14,
                                      ).tr(),
                                      value: "male",
                                      groupValue: state.selectedGender ?? '',
                                      onChanged: (value) {
                                        if (value != null) {
                                          context
                                              .read<SignupViewModel>()
                                              .doIntent(
                                                SelectGenderIntent(
                                                  selectGender: value,
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile<String>(
                                      title: Text(
                                        "female".tr(),
                                        style: context.appTheme.regular14,
                                      ).tr(),
                                      value: "female",
                                      groupValue: state.selectedGender ?? '',
                                      onChanged: (value) {
                                        if (value != null) {
                                          context
                                              .read<SignupViewModel>()
                                              .doIntent(
                                                SelectGenderIntent(
                                                  selectGender: value,
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "Creating an account, you agree to our ".tr(),
                          style: context.appTheme.regular12,
                        ),
                        InkWell(
                          onTap: () {
                            signUpViewModel.doEvent(
                              SignupNavigateToTermsConditions(),
                            );
                          },
                          child: Text(
                            "Terms&Conditions".tr(),
                            style: context.appTheme.semiBold12.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    BlocListener<SignupViewModel, SignupStates>(
                      listenWhen: (previous, current) {
                        return previous.signUpState != current.signUpState;
                      },
                      listener: (context, state) {
                        final signUpState = state.signUpState;
                        if (signUpState == null) {
                          return;
                        } else if (signUpState.errorMessage != null) {
                          signUpState.isError == true;
                          signUpViewModel.doEvent(
                            SignupShowToast(
                              message: signUpState.errorMessage!,
                              isError: signUpState.isError,
                            ),
                          );
                        } else if (signUpState.data != null) {
                          signUpState.isError == false;

                          signUpViewModel.doEvent(
                            SignupShowToast(
                              message: "account_created_success".tr(),
                              isError: signUpState.isError,
                            ),
                          );

                          signUpViewModel.doEvent(SignupNavigateToLogin());
                        }
                      },
                      child: ElevatedButton(
                        onPressed: validateSignUP,
                        child: Text('signup'.tr()),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            "Already have an account? ".tr(),
                            style: context.appTheme.regular16,
                          ),
                          InkWell(
                            onTap: () {
                              signUpViewModel.doEvent(SignupNavigateToLogin());
                            },
                            child: Text(
                              "Login".tr(),
                              style: context.appTheme.regular16.copyWith(
                                decoration: TextDecoration.underline,
                                color: context.appTheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateSignUP() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final currentState = signUpViewModel.state;
      signUpViewModel.doIntent(
        UserSignupIntent(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          rePassword: confirmPasswordController.text,
          phone: phoneController.text,
          gender: currentState.selectedGender ?? "",
        ),
      );
    }
  }
}
