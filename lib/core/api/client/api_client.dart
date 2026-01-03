import 'package:dio/dio.dart';
import 'package:flower_app/features/auth/data/models/requests/login_request.dart';
import 'package:flower_app/features/auth/data/models/response/login_response.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/features/auth/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/data/models/requests/send_reset_password_code_request.dart';
import 'package:flower_app/features/auth/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:retrofit/retrofit.dart';
import '../../constants/end_points.dart';
import '../../../features/auth/data/models/requests/signup_request.dart';
import '../../../features/auth/data/models/response/signup_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(EndPoints.login)
  Future<LoginResponse> login({@Body() required LoginRequest loginRequest});

  @POST(EndPoints.signUpEndpoint)
  Future<SignupResponse> signUp(@Body() SignupRequest userRequest);

  @POST(EndPoints.forgetPassword)
  Future<SendResetPasswordCodeResponse> sendResetPasswordCode({
    @Body() required SendResetPasswordCodeRequest sendResetPasswordCodeRequest,
  });

  @POST(EndPoints.verifyResetCode)
  Future<VerifyResetCodeResponse> verifyResetPasswordCode({
    @Body() required VerifyResetCodeRequest verifyResetCodeRequest,
  });

  @PUT(EndPoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword({
    @Body() required ResetPasswordRequest resetPasswordRequest,
  });
}
