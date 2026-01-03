import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/login_response.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepo {
  Future<Result<LoginResponse>> login({required String email, password});

  Future<Result<UserEntity>> signup({
    required String firstName,
    lastName,
    phone,
    gender,
    email,
    password,
    rePassword,
  });

  Future<Result<SendResetPasswordCodeResponse>> sendResetPasswordCode({
    required String email,
  });

  Future<Result<VerifyResetCodeResponse>> verifyResetPasswordCode({
    required String resetCode,
  });

  Future<Result<ResetPasswordResponse>> resetPassword({
    required String email,
    password,
  });
}
