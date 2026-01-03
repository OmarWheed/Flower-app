sealed class SignupViewIntent {}

class UserSignupIntent extends SignupViewIntent {
  String firstName, lastName, email, password, rePassword, phone, gender;

  UserSignupIntent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
    required this.gender,
  });
}

class SelectGenderIntent extends SignupViewIntent {
  String selectGender;

  SelectGenderIntent({required this.selectGender});
}
