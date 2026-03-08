import 'package:flower_app/core/api/models/requests/user_request.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/core/helper/local_keys.dart';
import 'package:flower_app/features/auth/data/datasources/auth_ds.dart';
import 'package:flower_app/features/auth/data/models/requests/change_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/data/models/response/change_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_request.dart';
import 'package:flower_app/features/auth/data/models_dto/login/login_response_dto.dart';
import 'package:flower_app/features/auth/data/models_dto/logout/logout_response_dto.dart';
import 'package:flower_app/features/auth/domain/models/logout_response_entity.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

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
  Future<Result<LoginResponseDto>> login({
    required LoginRequest loginRequest,
  }) async {
    var response = await _authDataSource.login(loginRequest: loginRequest);
    switch (response) {
      case Success<LoginResponseDto>():
        {
          var userId = response.data.userDto?.id;
          await AppLocalStorage.setData(LocalKeys.userId, userId);
          return Success<LoginResponseDto>(response.data);
        }
      case Failure<LoginResponseDto>():
        {
          return Failure<LoginResponseDto>(response.errorMessage);
        }
    }
  }

  @override
  Future<Result<UserEntity>> signUp(UserSignupRequest request) async {
    Result<UserDto> userDtoResponse = await _authDataSource.signUp(request);
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

  @override
  Future<Result<LogoutResponseEntity>> logout() async {
    Result<LogoutResponseDto> logoutDtoResponse = await _authDataSource
        .logout();
    switch (logoutDtoResponse) {
      case Success<LogoutResponseDto>():
        {
          LogoutResponseDto logoutResponseDto = logoutDtoResponse.data;
          LogoutResponseEntity logoutResponseEntity = logoutResponseDto
              .toEntity();
          return Success<LogoutResponseEntity>(logoutResponseEntity);
        }
      case Failure<LogoutResponseDto>():
        {
          return Failure<LogoutResponseEntity>(logoutDtoResponse.errorMessage);
        }
    }
  }

  @override
  Future<Result<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest changePasswordRequest,
  }) async {
    var response = await _authDataSource.changePassword(
      changePasswordRequest: changePasswordRequest,
    );
    switch (response) {
      case Success<ChangePasswordResponse>():
        {
          return Success<ChangePasswordResponse>(response.data);
        }
      case Failure<ChangePasswordResponse>():
        {
          return Failure<ChangePasswordResponse>(response.errorMessage);
        }
    }
  }
}
