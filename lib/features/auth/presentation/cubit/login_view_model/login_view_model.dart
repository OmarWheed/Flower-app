import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/core/helper/local_keys.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:flower_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/di/di.dart';

part 'login_state.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  final _uiEventsController = StreamController<LoginUIEvents>.broadcast();

  Stream<LoginUIEvents> get uiEventsStream => _uiEventsController.stream;

  LoginViewModel(this._loginUseCase) : super(LoginState.initial());

  void doIntent(LoginViewIntent intent) {
    switch (intent) {
      case UserLoginIntent():
        _login(email: intent.email, password: intent.password);
      case GuestLoginIntent():
        _guestLogin();
      case SignupIntent():
        _navigateToSignup();
      case ForgetPasswordIntent():
        _navigateToForgetPassword();
    }
  }

  void _login({required String email, required String password}) async {
    emit(state.copyWith(isLoading: true));
    final request = LoginRequest(email: email, password: password);
    var response = await _loginUseCase.login(loginRequest: request);
    switch (response) {
      case Success<LoginResponseDto>():


        await AppLocalStorage.setSecuredString(
          key: LocalKeys.authToken,
          value: response.data.token ?? '',
        );
        final user = response.data.userDto;
        if (user != null) {
          await AppLocalStorage.setData(
            LocalKeys.user,
            jsonEncode(user.toJson()),
          );
        }

        getIt<Dio>().options.headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${response.data.token}',
        };

        emit(state.copyWith(successMessage: response.data.message));
        _uiEventsController.add(NavigateToHome());

      case Failure<LoginResponseDto>():
        emit(state.copyWith());
        _uiEventsController.add(
          LoginViewShowToast(message: response.errorMessage, isError: true),
        );
    }
  }

  void _guestLogin() => _uiEventsController.add(NavigateToHome());

  void _navigateToSignup() => _uiEventsController.add(NavigateToSignup());

  void _navigateToForgetPassword() =>
      _uiEventsController.add(NavigateToForgetPassword());

  @override
  Future<void> close() {
    _uiEventsController.close();
    return super.close();
  }
}
