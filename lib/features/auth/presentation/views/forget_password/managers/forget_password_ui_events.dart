sealed class ForgetPasswordUIEvents {}

class ForgetPasswordShowToastEvent extends ForgetPasswordUIEvents {
  final String message;
  final bool isError;

  ForgetPasswordShowToastEvent(this.message, this.isError);
}

class NavigateToOTPEvent extends ForgetPasswordUIEvents {}

class NavigateToChangePasswordEvent extends ForgetPasswordUIEvents {}

class NavigateToLoginEvent extends ForgetPasswordUIEvents {}
