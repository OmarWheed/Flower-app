sealed class LoginUIEvents {}

final class NavigateToHome extends LoginUIEvents {}

final class NavigateToSignup extends LoginUIEvents {}

final class NavigateToForgetPassword extends LoginUIEvents {}

final class LoginViewShowToast extends LoginUIEvents {
  final String message;
  final bool isError;

  LoginViewShowToast({
    this.message = "Something went wrong",
    this.isError = false,
  });
}
