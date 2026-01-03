sealed class ForgetPasswordIntent {}

class SendResetPasswordCodeIntent extends ForgetPasswordIntent {
  final String email;
  SendResetPasswordCodeIntent(this.email);
}

class VerifyResetPasswordCodeIntent extends ForgetPasswordIntent {
  final String resetCode;
  VerifyResetPasswordCodeIntent(this.resetCode);
}

class ResetPasswordIntent extends ForgetPasswordIntent {
  final String email;
  final String password;
  ResetPasswordIntent(this.email, this.password);
}
