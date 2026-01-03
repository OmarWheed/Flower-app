import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';
import 'package:flower_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpUseCase {
  final AuthRepo repo;

  SignUpUseCase(this.repo);

  Future<Result<UserEntity>> call({
    required String firstName,
    lastName,
    email,
    password,
    rePassword,
    phone,
    gender,
  }) => repo.signup(
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password,
    rePassword: rePassword,
    phone: phone,
    gender: gender,
  );
}
