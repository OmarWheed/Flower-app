sealed class SignupUiEvent {}

class SignupShowToast extends SignupUiEvent {
  String message;
  bool isError;

  SignupShowToast({required this.message, required this.isError});
}

class SignupNavigateToLogin extends SignupUiEvent {}

class SignupNavigateToTermsConditions extends SignupUiEvent {}
