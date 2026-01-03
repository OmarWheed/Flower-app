import 'dart:async';

import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/reset_password_use_case.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/send_reset_password_code_use_case.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/verify_reset_password_code_use_case.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_intents.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_state.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_ui_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  final SendResetPasswordCodeUseCase _sendResetPasswordCodeUseCase;
  final VerifyResetPasswordCodeUseCase _verifyResetPasswordCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  Timer? _timer;

  final _uiEventsController =
      StreamController<ForgetPasswordUIEvents>.broadcast();

  Stream<ForgetPasswordUIEvents> get uiEventsStream =>
      _uiEventsController.stream;

  String? _savedEmail;

  late int _remainingSeconds;

  String? get savedEmail => _savedEmail;

  ForgetPasswordViewModel(
    this._sendResetPasswordCodeUseCase,
    this._verifyResetPasswordCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(const ForgetPasswordState());

  void doIntent(ForgetPasswordIntent intent) {
    switch (intent) {
      case SendResetPasswordCodeIntent():
        _sendResetPasswordCode(intent.email);

      case VerifyResetPasswordCodeIntent():
        _verifyResetPasswordCode(intent.resetCode);

      case ResetPasswordIntent():
        _resetPassword(intent.email, intent.password);
    }
  }

  Future<void> _sendResetPasswordCode(String email) async {
    emit(state.copyWith(isLoading: true));

    final result = await _sendResetPasswordCodeUseCase(email: email);

    switch (result) {
      case Success<SendResetPasswordCodeResponse>():
        _savedEmail = email;
        _resentOtpTimer();
        emit(
          state.copyWith(
            isLoading: false,
            message: result.data.message,
            error: '',
          ),
        );
        _uiEventsController.add(
          ForgetPasswordShowToastEvent(result.data.info, false),
        );
        _uiEventsController.add(NavigateToOTPEvent());

      case Failure<SendResetPasswordCodeResponse>():
        emit(
          state.copyWith(
            isLoading: false,
            error: result.errorMessage.toString(),
          ),
        );
        _uiEventsController.add(
          ForgetPasswordShowToastEvent(result.errorMessage, true),
        );
    }
  }

  Future<void> _verifyResetPasswordCode(String code) async {
    emit(state.copyWith(isLoading: true));

    final result = await _verifyResetPasswordCodeUseCase(resetCode: code);

    switch (result) {
      case Success<VerifyResetCodeResponse>():
        emit(
          state.copyWith(
            isLoading: false,
            message: result.data.message,
            error: '',
          ),
        );
        _uiEventsController.add(NavigateToChangePasswordEvent());
        _uiEventsController.add(
          ForgetPasswordShowToastEvent(result.data.message, false),
        );

      case Failure<VerifyResetCodeResponse>():
        emit(state.copyWith(isLoading: false, error: result.errorMessage));
        _uiEventsController.add(
          ForgetPasswordShowToastEvent(result.errorMessage.toString(), true),
        );
    }
  }

  Future<void> _resetPassword(String email, String password) async {
    emit(state.copyWith(isLoading: true));

    final result = await _resetPasswordUseCase(
      email: email,
      password: password,
    );

    switch (result) {
      case Success<ResetPasswordResponse>():
        _savedEmail = email;
        emit(state.copyWith(isLoading: false, message: result.data.message));
        _uiEventsController.add(
          ForgetPasswordShowToastEvent(result.data.message, false),
        );
        _uiEventsController.add(NavigateToLoginEvent());
      case Failure<ResetPasswordResponse>():
        emit(state.copyWith(isLoading: false, error: result.errorMessage));
        _uiEventsController.add(
          ForgetPasswordShowToastEvent(result.errorMessage.toString(), true),
        );
    }
  }

  void _resentOtpTimer() {
    _timer?.cancel();
    _remainingSeconds = 30;
    emit(state.copyWith(resendRemainingSeconds: _remainingSeconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingSeconds--;
      if (_remainingSeconds > 0) {
        emit(state.copyWith(resendRemainingSeconds: _remainingSeconds));
      } else {
        timer.cancel();
        emit(state.copyWith(resendRemainingSeconds: 0));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _uiEventsController.close();
    return super.close();
  }
}
