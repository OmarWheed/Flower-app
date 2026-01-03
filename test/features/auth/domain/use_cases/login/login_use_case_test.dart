import 'package:flower_app/features/auth/data/models/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/login_response.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower_app/features/auth/domain/use_cases/login/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../forget_password/reset_password_use_case_test.mocks.dart';

void main() {
  late AuthRepo authRepo;
  late LoginUseCase useCase;
  late String email, password, token, message;
  late UserDto userDto;
  late LoginResponse loginResponse;

  setUp(() {
    authRepo = MockAuthRepoImpl();
    useCase = LoginUseCase(authRepo);
    email = "joe@example.com";
    password = "Joe!@12345678";
    userDto = UserDto(id: "1");
    token = "abc123";
    message = "success";
    loginResponse = LoginResponse(
      userDto: userDto,
      token: token,
      message: message,
    );
  });
  test("when call Login it should call repo with correct params ", () {
    // arrange
    var response = Success(loginResponse);
    provideDummy<Result<LoginResponse>>(response);
    when(
      authRepo.login(email: email, password: password),
    ).thenAnswer((_) async => response);

    // act
    useCase.login(email: email, password: password);

    // assert
    verify(authRepo.login(email: email, password: password));
  });
}
