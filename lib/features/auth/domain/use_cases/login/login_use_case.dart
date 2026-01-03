import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/login_response.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginUseCase {
  final AuthRepo _authRepo;

  const LoginUseCase(this._authRepo);

  Future<Result<LoginResponse>> login({required String email, password}) =>
      _authRepo.login(email: email, password: password);
}
