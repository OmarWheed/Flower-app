import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/data_source/auth_data_source.dart';
import 'package:flower_app/features/auth/data/data_source/auth_data_source_impl.dart';
import 'package:flower_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/features/auth/data/models/user_dto.dart';
import 'package:flower_app/features/auth/data/models/requests/login_request.dart';
import 'package:flower_app/features/auth/data/models/response/login_response.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthDataSourceImpl])
void main() {
  late MockAuthDataSourceImpl mockAuthDataSource;
  late AuthRepoImpl authRepo;
  late LoginRequest loginRequest;
  late LoginResponse loginResponse;
  late Result<LoginResponse> response;
  late UserDto userDto;
  late UserEntity userEntity;

  late AuthDataSource authDataSource;
  // filling data
  late String email;
  late String resetCode;
  late String password;
  late String responseMessage;
  late String errorMessageResponse;
  // requests
  late SendResetPasswordCodeRequest sendResetPasswordCodeRequest;
  late VerifyResetCodeRequest verifyResetCodeRequest;
  late ResetPasswordRequest resetPasswordRequest;
  // responses
  late Result<SendResetPasswordCodeResponse> sendResetPasswordCodeResponse;
  late Result<VerifyResetCodeResponse> verifyResetCodeResponse;
  late Result<ResetPasswordResponse> resetPasswordResponse;

  setUpAll(() {
    authDataSource = MockAuthDataSourceImpl();
    email = "joe@example.com";
    resetCode = "112233";
    password = "Joe!@12345678";
    responseMessage = "success";
    errorMessageResponse = "error";
  });

  setUp(() {
    mockAuthDataSource = MockAuthDataSourceImpl();
    authRepo = AuthRepoImpl(mockAuthDataSource);
    // Ensure tests stub/verify the same mock instance
    authDataSource = mockAuthDataSource;

    loginRequest = const LoginRequest(
      email: "test@test.com",
      password: "123456",
    );
    loginResponse = LoginResponse(
      userDto: UserDto(id: "1"),
      token: "abc123",
      message: "success",
    );
    response = Success(loginResponse);

    provideDummy<Result<LoginResponse>>(response);

    when(
      mockAuthDataSource.login(loginRequest: loginRequest),
    ).thenAnswer((_) async => response);
    userDto = UserDto(
      id: "d",
      firstName: "abdo",
      lastName: "abdoa",
      email: "",
      phone: "12345",
      role: "role",
      addresses: [12, 45],
      gender: "male",
      createdAt: "2024-01-01T00:00:00Z",
      photo: "ddd",
      wishlist: [12, 45],
    );
    userEntity = UserEntity(
      id: "d",
      firstName: "abdo",
      lastName: "abdoa",
      email: "",
      phone: "12345",
      role: "role",
      addresses: [12, 45],
      gender: "male",
      photo: "ddd",
    );

    provideDummy<Result<UserDto>>(Success<UserDto>(userDto));
    provideDummy<Result<UserEntity>>(Success<UserEntity>(userEntity));
  });

  group("Testing sendResetPasswordCode cases", () {
    test("When i call sendResetPasswordCode it calls "
        "sendResetPasswordCode from "
        "data source and return Success result from data source "
        "and didn't call any other functions", () async {
      // arrange
      sendResetPasswordCodeResponse = Success<SendResetPasswordCodeResponse>(
        SendResetPasswordCodeResponse(message: responseMessage, info: "info"),
      );
      provideDummy<Result<SendResetPasswordCodeResponse>>(
        sendResetPasswordCodeResponse,
      );
      sendResetPasswordCodeRequest = SendResetPasswordCodeRequest(email: email);
      when(
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);
      // act
      var result = await authRepo.sendResetPasswordCode(email: email);
      // assert
      verify(
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(
        (result as Success<SendResetPasswordCodeResponse>).data.message,
        responseMessage,
      );
    });

    test("When i call sendResetPasswordCode it calls "
        "sendResetPasswordCode from "
        "data source and return Failure result from data source "
        "and didn't call any other functions", () async {
      // arrange
      sendResetPasswordCodeResponse = Failure<SendResetPasswordCodeResponse>(
        errorMessageResponse,
      );
      provideDummy<Result<SendResetPasswordCodeResponse>>(
        sendResetPasswordCodeResponse,
      );
      sendResetPasswordCodeRequest = SendResetPasswordCodeRequest(email: email);
      when(
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).thenAnswer((_) async => sendResetPasswordCodeResponse);
      // act
      var result = await authRepo.sendResetPasswordCode(email: email);
      // assert
      verify(
        authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(
        (result as Failure<SendResetPasswordCodeResponse>).errorMessage,
        errorMessageResponse,
      );
    });
  });

  group("Testing verifyResetPasswordCode cases", () {
    test("When i call verifyResetPasswordCode it calls "
        "verifyResetPasswordCode from "
        "data source and return Success result from data source "
        "and didn't call any other functions", () async {
      // arrange
      verifyResetCodeResponse = Success<VerifyResetCodeResponse>(
        VerifyResetCodeResponse(message: responseMessage),
      );
      provideDummy<Result<VerifyResetCodeResponse>>(verifyResetCodeResponse);
      verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
      when(
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer((_) async => verifyResetCodeResponse);
      // act
      var result = await authRepo.verifyResetPasswordCode(resetCode: resetCode);
      // assert
      verify(
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(
        (result as Success<VerifyResetCodeResponse>).data.message,
        responseMessage,
      );
    });

    test("When i call verifyResetPasswordCode it calls "
        "verifyResetPasswordCode from "
        "data source and return Failure result from data source "
        "and didn't call any other functions", () async {
      // arrange
      verifyResetCodeResponse = Failure<VerifyResetCodeResponse>(
        errorMessageResponse,
      );
      provideDummy<Result<VerifyResetCodeResponse>>(verifyResetCodeResponse);
      verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
      when(
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).thenAnswer((_) async => verifyResetCodeResponse);
      // act
      var result = await authRepo.verifyResetPasswordCode(resetCode: resetCode);
      // assert
      verify(
        authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(
        (result as Failure<VerifyResetCodeResponse>).errorMessage,
        errorMessageResponse,
      );
    });
  });

  group("Testing resetPassword cases", () {
    test("When i call resetPassword it calls "
        "resetPassword from "
        "data source and return Success result from data source "
        "and didn't call any other functions", () async {
      // arrange
      resetPasswordResponse = Success<ResetPasswordResponse>(
        ResetPasswordResponse(message: responseMessage, token: "token"),
      );
      provideDummy<Result<ResetPasswordResponse>>(resetPasswordResponse);
      resetPasswordRequest = ResetPasswordRequest(
        email: email,
        password: password,
      );
      when(
        authDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).thenAnswer((_) async => resetPasswordResponse);
      // act
      var result = await authRepo.resetPassword(
        email: email,
        password: password,
      );
      // assert
      verify(
        authDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(
        (result as Success<ResetPasswordResponse>).data.message,
        responseMessage,
      );
    });

    test("When i call resetPassword it calls "
        "resetPassword from "
        "data source and return Failure result from data source "
        "and didn't call any other functions", () async {
      // arrange
      resetPasswordResponse = Failure<ResetPasswordResponse>(
        errorMessageResponse,
      );
      provideDummy<Result<ResetPasswordResponse>>(resetPasswordResponse);
      resetPasswordRequest = ResetPasswordRequest(
        email: email,
        password: password,
      );
      when(
        authDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).thenAnswer((_) async => resetPasswordResponse);
      // act
      var result = await authRepo.resetPassword(
        email: email,
        password: password,
      );
      // assert
      verify(
        authDataSource.resetPassword(
          resetPasswordRequest: resetPasswordRequest,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
      expect(
        (result as Failure<ResetPasswordResponse>).errorMessage,
        errorMessageResponse,
      );
    });
  });
}
