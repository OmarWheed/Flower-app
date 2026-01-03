import 'dart:async';
import 'dart:convert';

import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/core/helper/local_keys.dart';
import 'package:flower_app/features/auth/data/models/response/login_response.dart';
import 'package:flower_app/features/auth/domain/use_cases/login/login_use_case.dart';
import 'package:flower_app/features/auth/presentation/views/login/managers/login_view_events.dart';
import 'package:flower_app/features/auth/presentation/views/login/managers/login_view_intents.dart';
import 'package:flower_app/features/auth/presentation/views/login/managers/login_view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginViewState> {
  final LoginUseCase _loginUseCase;

  final _uiEventsController = StreamController<LoginUIEvents>.broadcast();

  Stream<LoginUIEvents> get uiEventsStream => _uiEventsController.stream;

  LoginViewModel(this._loginUseCase) : super(LoginViewState.initial());

  void doIntent(LoginViewIntent intent) {
    switch (intent) {
      case UserLoginIntent():
        _login(email: intent.email, password: intent.password);
      case GuestLoginIntent():
        _guestLogin();
      case NavToSignupIntent():
        _navigateToSignup();
      case NavToForgetPasswordIntent():
        _navigateToForgetPassword();
    }
  }

  _login({required String email, required String password}) async {
    emit(state.copyWith(isLoading: true));
    var response = await _loginUseCase.login(email: email, password: password);
    switch (response) {
      case Success<LoginResponse>():
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

        emit(state.copyWith(successMessage: response.data.message));
        _uiEventsController.add(NavigateToHome());

      case Failure<LoginResponse>():
        emit(state.copyWith());
        _uiEventsController.add(
          LoginViewShowToast(message: response.errorMessage, isError: true),
        );
    }
  }

  _guestLogin() => _uiEventsController.add(NavigateToHome());

  _navigateToSignup() => _uiEventsController.add(NavigateToSignup());

  _navigateToForgetPassword() =>
      _uiEventsController.add(NavigateToForgetPassword());
}
