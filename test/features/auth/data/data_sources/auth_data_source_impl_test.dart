import 'package:dio/dio.dart';
import 'package:flower_app/core/api/client/api_client.dart';
import 'package:flower_app/features/auth/data/data_source/auth_data_source.dart';
import 'package:flower_app/features/auth/data/data_source/auth_data_source_impl.dart';
import 'package:flower_app/features/auth/data/models/requests/signup_request.dart';
import 'package:flower_app/features/auth/data/models/response/signup_response.dart';
import 'package:flower_app/features/auth/data/models/user_dto.dart';
import 'package:flower_app/core/error_handling/handle_exception%20.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/requests/login_request.dart';
import 'package:flower_app/features/auth/data/models/response/login_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';

import 'auth_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late AuthDataSourceImpl dataSource;
  late LoginRequest loginRequest;
  late LoginResponse loginResponse;
  late DioException dioException;
  late MockApiClient mockApiClient;
  late SignupRequest userRequest;
  late UserDto user;
  late SignupResponse dummySignupResponse;
  /////////
  late AuthDataSource authDataSource;
  late ApiClient apiClient;
  // filling data
  late String email;
  late String resetCode;
  late String password;
  late String responseMessage;
  late String token;
  // requests
  late SendResetPasswordCodeRequest sendResetPasswordCodeRequest;
  late VerifyResetCodeRequest verifyResetCodeRequest;
  late ResetPasswordRequest resetPasswordRequest;
  // responses
  late SendResetPasswordCodeResponse sendResetPasswordCodeResponse;
  late VerifyResetCodeResponse verifyResetCodeResponse;
  late ResetPasswordResponse resetPasswordResponse;

  Exception e = Exception('Exception');

  setUp(() {
    // Arrange
    mockApiClient = MockApiClient();
    dataSource = AuthDataSourceImpl(mockApiClient);

    mockApiClient = MockApiClient();
    dataSource = AuthDataSourceImpl(mockApiClient);
    loginRequest = const LoginRequest(
      email: "test@test.com",
      password: "123456",
    );

    loginResponse = LoginResponse(
      message: "success",
      token: "abc123",
      userDto: UserDto(id: "1"),
    );

    userRequest = SignupRequest(
      gender: "male",
      firstName: "abdo",
      lastName: "abdoa",
      email: "abdo@d.com",
      password: "dd",
      rePassword: "dd",
      phone: "12345",
    );
    user = UserDto(
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
    dummySignupResponse = SignupResponse(
      message: "message",
      userDto: user,
      token: "token",
    );
    apiClient = MockApiClient();
    email = "joe@example.com";
    resetCode = "112233";
    password = "Joe!@12345678";
    responseMessage = "message";
    token = "token";
    dioException = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionError,
    );
    authDataSource = AuthDataSourceImpl(apiClient);
    // requests
    sendResetPasswordCodeRequest = SendResetPasswordCodeRequest(email: email);
    verifyResetCodeRequest = VerifyResetCodeRequest(resetCode: resetCode);
    resetPasswordRequest = ResetPasswordRequest(
      email: email,
      password: password,
    );
    // responses
    sendResetPasswordCodeResponse = SendResetPasswordCodeResponse(
      message: responseMessage,
      info: "",
    );
    verifyResetCodeResponse = VerifyResetCodeResponse(message: responseMessage);
    resetPasswordResponse = ResetPasswordResponse(
      message: responseMessage,
      token: token,
    );
  });

  test(
    "should return Success<LoginResponse> with correct token when login succeeds",
    () async {
      // Arrange
      when(
        mockApiClient.login(loginRequest: loginRequest),
      ).thenAnswer((_) async => loginResponse);

      // Act
      final result = await dataSource.login(loginRequest: loginRequest);

      // Assert
      expect(result, isA<Success<LoginResponse>>());
      final success = result as Success<LoginResponse>;
      expect(success.data.token, equals(loginResponse.token));
      verify(mockApiClient.login(loginRequest: loginRequest)).called(1);
      verifyNoMoreInteractions(mockApiClient);
    },
  );

  test("should return Failure when API throws DioException", () async {
    // Arrange
    when(
      mockApiClient.login(loginRequest: loginRequest),
    ).thenThrow(dioException);

    // Act
    final result = await dataSource.login(loginRequest: loginRequest);

    // Assert
    verify(mockApiClient.login(loginRequest: loginRequest)).called(1);
    verifyNoMoreInteractions(mockApiClient);
    expect(
      (result as Failure).errorMessage,
      equals(NetworkException.getMessageError(dioException)),
    );
  });

  test('when call signUp it should return Success', () async {
    provideDummy<Result<UserDto>>(Success<UserDto>(user));

    when(
      mockApiClient.signUp(userRequest),
    ).thenAnswer((_) async => dummySignupResponse);
    final result = await dataSource.signup(signupRequest: userRequest);
    expect(result, isA<Success<UserDto>>());
    expect(result as Success<UserDto>, isNotNull);
    expect(result.data.id, equals(user.id));
    expect(result.data.firstName, equals(user.firstName));
    expect(result.data.lastName, equals(user.lastName));
    expect(result.data.email, equals(user.email));
    expect(result.data.phone, equals(user.phone));
    expect(result.data.role, equals(user.role));
    expect(result.data.createdAt, equals(user.createdAt));
    expect(result.data.gender, equals(user.gender));
    expect(result.data.addresses, equals(user.addresses));
    expect(result.data.photo, equals(user.photo));
    expect(result.data.wishlist?.length, equals(user.wishlist?.length));
    verify(mockApiClient.signUp(userRequest)).called(1);
  });
  test('when call signUp it should return Failure', () async {
    provideDummy<Result<UserDto>>(Failure<UserDto>(e.toString()));
    when(mockApiClient.signUp(userRequest)).thenThrow(e);
    final result = await dataSource.signup(signupRequest: userRequest);
    expect(result, isA<Failure<UserDto>>());
    expect(result as Failure<UserDto>, isNotNull);
    expect(result.errorMessage, equals(e.toString()));
    verify(mockApiClient.signUp(userRequest)).called(1);
  });
  group("Testing sendResetPasswordCode cases", () {
    test(
      "When i call sendResetPasswordCode it calls sendResetPasswordCode from "
      "api client and return Success result from api client "
      "and didn't call any other functions",
      () async {
        // arrange
        when(
          apiClient.sendResetPasswordCode(
            sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
          ),
        ).thenAnswer((_) async => sendResetPasswordCodeResponse);
        // act
        var result =
            await authDataSource.sendResetPasswordCode(
                  sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
                )
                as Success<SendResetPasswordCodeResponse>;
        // assert
        verify(
          apiClient.sendResetPasswordCode(
            sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
          ),
        ).called(1);
        verifyNoMoreInteractions(apiClient);

        expect(result.data.message, sendResetPasswordCodeResponse.message);
      },
    );

    test(
      "When i call sendResetPasswordCode it calls sendResetPasswordCode from "
      "api client and return failure result if there is an dio exception"
      "and didn't call any other functions",
      () async {
        // arrange
        when(
          apiClient.sendResetPasswordCode(
            sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
          ),
        ).thenThrow(dioException);
        // act
        var result = await authDataSource.sendResetPasswordCode(
          sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
        );
        // assert
        verify(
          apiClient.sendResetPasswordCode(
            sendResetPasswordCodeRequest: sendResetPasswordCodeRequest,
          ),
        ).called(1);
        verifyNoMoreInteractions(apiClient);

        expect(
          (result as Failure<SendResetPasswordCodeResponse>).errorMessage,
          "errors.connectionError",
        );
      },
    );
  });

  group("Testing verifyResetPasswordCode cases", () {
    test(
      "When i call verifyResetPasswordCode it calls verifyResetPasswordCode from "
      "api client and return Success result from api client "
      "and didn't call any other functions",
      () async {
        // arrange
        when(
          apiClient.verifyResetPasswordCode(
            verifyResetCodeRequest: verifyResetCodeRequest,
          ),
        ).thenAnswer((_) async => verifyResetCodeResponse);
        // act
        var result = await authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        );
        // assert
        verify(
          apiClient.verifyResetPasswordCode(
            verifyResetCodeRequest: verifyResetCodeRequest,
          ),
        ).called(1);
        verifyNoMoreInteractions(apiClient);
        expect(
          (result as Success<VerifyResetCodeResponse>).data.message,
          verifyResetCodeResponse.message,
        );
      },
    );
    test(
      "When i call verifyResetPasswordCode it calls verifyResetPasswordCode from "
      "api client and return failure result if there is an dio exception"
      "and didn't call any other functions",
      () async {
        // arrange
        when(
          apiClient.verifyResetPasswordCode(
            verifyResetCodeRequest: verifyResetCodeRequest,
          ),
        ).thenThrow(dioException);
        // act
        var result = await authDataSource.verifyResetPasswordCode(
          verifyResetCodeRequest: verifyResetCodeRequest,
        );
        // assert
        verify(
          apiClient.verifyResetPasswordCode(
            verifyResetCodeRequest: verifyResetCodeRequest,
          ),
        ).called(1);
        verifyNoMoreInteractions(apiClient);

        expect(
          (result as Failure<VerifyResetCodeResponse>).errorMessage,
          "errors.connectionError",
        );
      },
    );
  });

  group("Testing resetPassword cases", () {
    test("When i call resetPassword it calls resetPassword from "
        "api client and return Success result from api client "
        "and didn't call any other functions", () async {
      // arrange
      when(
        apiClient.resetPassword(resetPasswordRequest: resetPasswordRequest),
      ).thenAnswer((_) async => resetPasswordResponse);
      // act
      var result = await authDataSource.resetPassword(
        resetPasswordRequest: resetPasswordRequest,
      );
      // assert
      verify(
        apiClient.resetPassword(resetPasswordRequest: resetPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(apiClient);

      expect(
        (result as Success<ResetPasswordResponse>).data.message,
        resetPasswordResponse.message,
      );
    });
    test("When i call resetPassword it calls resetPassword from "
        "api client and return failure result if there is an dio exception"
        "and didn't call any other functions", () async {
      // arrange
      when(
        apiClient.resetPassword(resetPasswordRequest: resetPasswordRequest),
      ).thenThrow(dioException);
      // act
      var result = await authDataSource.resetPassword(
        resetPasswordRequest: resetPasswordRequest,
      );
      // assert
      verify(
        apiClient.resetPassword(resetPasswordRequest: resetPasswordRequest),
      ).called(1);
      verifyNoMoreInteractions(apiClient);

      expect(
        (result as Failure<ResetPasswordResponse>).errorMessage,
        "errors.connectionError",
      );
    });
  });
}
