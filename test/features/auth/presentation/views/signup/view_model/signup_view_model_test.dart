import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';
import 'package:flower_app/features/auth/domain/use_cases/signup/signup_use_case.dart';
import 'package:flower_app/features/auth/presentation/views/signup/managers/signup_view_intent.dart';
import 'package:flower_app/features/auth/presentation/views/signup/managers/signup_view_states.dart';
import 'package:flower_app/features/auth/presentation/views/signup/view_model/signup_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_view_model_test.mocks.dart';

@GenerateMocks([SignUpUseCase])
void main() {
  late MockSignUpUseCase mockSignUpUseCase;
  late SignupViewModel viewModel;
  late String email, password, rePassword, firstname, lastname, gender, phone;
  late UserEntity dummyUser;

  setUp(() {
    mockSignUpUseCase = MockSignUpUseCase();
    viewModel = SignupViewModel(mockSignUpUseCase);

    firstname = "Abdo";
    lastname = "Salah";
    email = "abdo@gmail.com";
    password = "Abdo!11112222";
    rePassword = "Abdo!11112222";
    phone = "+201111111111";
    gender = 'male';

    dummyUser = UserEntity(
      id: "id",
      firstName: "Abdo",
      lastName: "Salah",
      email: "abdo@gmail.com",
      phone: "+201111111111",
      role: "user",
      addresses: [12, 45],
      gender: "male",
      photo: "imageUrl.com",
    );
    provideDummy<Result<UserEntity>>(Success<UserEntity>(dummyUser));
  });

  blocTest<SignupViewModel, SignupStates>(
    ' emits [loading, success] when signUpUseCase returns Success',
    build: () {
      when(
        mockSignUpUseCase(
          firstName: firstname,
          lastName: lastname,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phone,
          gender: gender,
        ),
      ).thenAnswer((_) async => Success<UserEntity>(dummyUser));
      return viewModel;
    },
    act: (bloc) => bloc.doIntent(
      UserSignupIntent(
        firstName: firstname,
        lastName: lastname,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone,
        gender: gender,
      ),
    ),
    expect: () {
      var state = const SignupStates(
        signUpState: BaseState<UserEntity>(requestState: RequestState.loading),
      );
      return [
        state.copyWith(
          signUpState: const BaseState<UserEntity>(
            requestState: RequestState.loading,
          ),
        ),
        state.copyWith(
          signUpState: BaseState<UserEntity>(
            data: dummyUser,
            requestState: RequestState.loaded,
          ),
        ),
      ];
    },
    verify: (_) {
      verify(
        mockSignUpUseCase(
          firstName: firstname,
          lastName: lastname,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phone,
          gender: gender,
        ),
      ).called(1);
    },
  );

  blocTest<SignupViewModel, SignupStates>(
    ' emits [loading, error] when signUpUseCase returns error',
    build: () {
      when(
        mockSignUpUseCase(
          firstName: firstname,
          lastName: lastname,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phone,
          gender: gender,
        ),
      ).thenAnswer((_) async => Failure<UserEntity>("Signup Failed"));
      return viewModel;
    },
    act: (bloc) => bloc.doIntent(
      UserSignupIntent(
        firstName: firstname,
        lastName: lastname,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone,
        gender: gender,
      ),
    ),
    expect: () {
      var state = const SignupStates(
        signUpState: BaseState<UserEntity>(requestState: RequestState.loading),
      );
      return [
        state.copyWith(
          signUpState: const BaseState<UserEntity>(
            requestState: RequestState.loading,
          ),
        ),
        state.copyWith(
          signUpState: const BaseState<UserEntity>(
            errorMessage: "Signup Failed",
            requestState: RequestState.error,
          ),
        ),
      ];
    },
    verify: (_) {
      verify(
        mockSignUpUseCase(
          firstName: firstname,
          lastName: lastname,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phone,
          gender: gender,
        ),
      ).called(1);
    },
  );
  blocTest<SignupViewModel, SignupStates>(
    'emits state with selectedGender when SelectGender event is triggered',
    build: () => viewModel,
    act: (bloc) => bloc.doIntent(SelectGenderIntent(selectGender: "male")),
    expect: () => [const SignupStates(selectedGender: "male")],
  );
}
