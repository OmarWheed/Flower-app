import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower_app/features/auth/domain/use_cases/signup/signup_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../forget_password/reset_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepoImpl])
void main() {
  late AuthRepo authRepo;
  late SignUpUseCase useCase;
  late String email, password, rePassword, firstname, lastname, gender, phone;
  late UserEntity userEntity;

  setUp(() {
    authRepo = MockAuthRepoImpl();
    useCase = SignUpUseCase(authRepo);

    userEntity = UserEntity(
      addresses: ["abdo"],
      firstName: "abdo",
      lastName: "abdoa",
      email: "abdo@d.com",
      phone: "12345",
      role: "role",
      gender: "male",
      id: "Id",
      photo: "2024-01-01T00:00:00Z",
    );
    firstname = "abdo";
    lastname = "salah";
    email = "abdo@gmail.com";
    password = "Abdo!11112222";
    rePassword = "Abdo!11112222";
    phone = "+201111111111";
    gender = 'male';
  });

  test('tests calling SignU in use_cases.dart', () async {
    // arrange
    var response = Success<UserEntity>(userEntity);
    provideDummy<Result<UserEntity>>(Success<UserEntity>(userEntity));
    when(
      authRepo.signup(
        firstName: firstname,
        lastName: lastname,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone,
      ),
    ).thenAnswer((_) async => response);

    //act
    await useCase.call(
      firstName: firstname,
      lastName: lastname,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
      gender: gender,
    );

    // assert
    verify(
      authRepo.signup(
        firstName: firstname,
        lastName: lastname,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone,
        gender: gender,
      ),
    ).called(1);
  });
}
