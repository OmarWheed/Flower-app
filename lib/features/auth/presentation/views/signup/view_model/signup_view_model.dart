import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';
import 'package:flower_app/features/auth/domain/use_cases/signup/signup_use_case.dart';
import 'package:flower_app/features/auth/presentation/views/signup/managers/signup_view_event.dart';
import 'package:flower_app/features/auth/presentation/views/signup/managers/signup_view_intent.dart';
import 'package:flower_app/features/auth/presentation/views/signup/managers/signup_view_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupViewModel extends Cubit<SignupStates> with EquatableMixin {
  final SignUpUseCase _signUpUseCase;

  SignupViewModel(this._signUpUseCase) : super(const SignupStates());

  final StreamController<SignupUiEvent> _signupUiEvent =
      StreamController.broadcast();

  Stream<SignupUiEvent> get signupUiEvent => _signupUiEvent.stream;

  void doIntent(SignupViewIntent intent) {
    switch (intent) {
      case UserSignupIntent():
        _signUp(
          firstName: intent.firstName,
          lastName: intent.lastName,
          email: intent.email,
          password: intent.password,
          rePassword: intent.rePassword,
          phone: intent.phone,
          gender: intent.gender,
        );
      case SelectGenderIntent():
        _selectedGender(intent.selectGender);
    }
  }

  void doEvent(SignupUiEvent event) {
    switch (event) {
      case SignupShowToast():
        _signupUiEvent.add(
          SignupShowToast(message: event.message, isError: event.isError),
        );
      case SignupNavigateToLogin():
        _signupUiEvent.add(SignupNavigateToLogin());
      case SignupNavigateToTermsConditions():
        _signupUiEvent.add(SignupNavigateToTermsConditions());
    }
  }

  void _signUp({
    required String firstName,
    lastName,
    email,
    password,
    rePassword,
    phone,
    gender,
  }) async {
    emit(
      state.copyWith(
        signUpState: const BaseState<UserEntity>(
          requestState: RequestState.loading,
        ),
      ),
    );
    var result = await _signUpUseCase.call(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
      gender: gender,
    );

    switch (result) {
      case Success<UserEntity>():
        emit(
          state.copyWith(
            signUpState: BaseState<UserEntity>.loaded(result.data),
          ),
        );
      case Failure<UserEntity>():
        emit(
          state.copyWith(
            signUpState: BaseState<UserEntity>.error(
              result.errorMessage.toString(),
            ),
          ),
        );
    }
  }

  void _selectedGender(String selectGender) {
    emit(state.copyWith(selectedGender: selectGender));
  }

  @override
  List<Object> get props => [state];
}
