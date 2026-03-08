import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';

abstract interface class AppSectionsRepo {
  Future<Result<UserEntity>> getUserData();

  Future<Result<void>> upLoadUserData({
    required String collectionPath,
    required String userId,
    required Map<String, dynamic> data,
  });
}
