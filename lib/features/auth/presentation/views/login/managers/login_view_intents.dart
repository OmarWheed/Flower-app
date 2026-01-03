sealed class LoginViewIntent {}

final class UserLoginIntent extends LoginViewIntent {
  final String email;
  final String password;

  UserLoginIntent({required this.email, required this.password});
}

final class GuestLoginIntent extends LoginViewIntent {}

final class NavToSignupIntent extends LoginViewIntent {}

final class NavToForgetPasswordIntent extends LoginViewIntent {}
