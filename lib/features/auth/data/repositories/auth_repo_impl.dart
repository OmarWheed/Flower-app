import 'package:flower_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/requests/signup_request.dart';
import 'package:flower_app/features/auth/data/models/user_dto.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';
import 'package:flower_app/features/auth/data/models/requests/login_request.dart';
import 'package:flower_app/features/auth/data/models/response/login_response.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../data_source/auth_data_source.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;

  const AuthRepoImpl(this._authDataSource);

  @override
  Future<Result<ResetPasswordResponse>> resetPassword({
    required String email,
    password,
  }) {
    var resetPasswordRequest = ResetPasswordRequest(
      email: email,
      password: password,
    );
    return _authDataSource.resetPassword(
      resetPasswordRequest: resetPasswordRequest,
    );
  }

  @override
  Future<Result<SendResetPasswordCodeResponse>> sendResetPasswordCode({
    required String email,
  }) {
    var sendResetPasswordCodeRequest = SendResetPasswordCodeRequest(
      email: email,
    );
    return _authDataSource.sendResetPasswordCode(
      sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
    );
  }

  @override
  Future<Result<VerifyResetCodeResponse>> verifyResetPasswordCode({
    required String resetCode,
  }) {
    var verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
    return _authDataSource.verifyResetPasswordCode(
      verifyResetCodeRequest: verifyResetCodeRequest,
    );
  }

  @override
  Future<Result<LoginResponse>> login({required String email, password}) async {
    var loginRequest = LoginRequest(email: email, password: password);
    var response = await _authDataSource.login(loginRequest: loginRequest);
    switch (response) {
      case Success<LoginResponse>():
        {
          return Success<LoginResponse>(response.data);
        }
      case Failure<LoginResponse>():
        {
          return Failure<LoginResponse>(response.errorMessage);
        }
    }
  }

  @override
  Future<Result<UserEntity>> signup({
    required String firstName,
    lastName,
    phone,
    gender,
    email,
    password,
    rePassword,
  }) async {
    var signupRequest = SignupRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
      gender: gender,
    );
    Result<UserDto> userDtoResponse = await _authDataSource.signup(
      signupRequest: signupRequest,
    );
    switch (userDtoResponse) {
      case Success<UserDto>():
        {
          UserDto userDto = userDtoResponse.data;
          UserEntity users = userDto.toEntity();
          return Success<UserEntity>(users);
        }

      case Failure<UserDto>():
        {
          return Failure<UserEntity>(userDtoResponse.errorMessage);
        }
    }
  }
}
