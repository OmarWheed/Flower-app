import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/app/data/data_source/app_sections_data_source.dart';
import 'package:flower_app/core/app/domain/repositories/app_sections_repo.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AppSectionsRepo)
class AppSectionsRepoImpl implements AppSectionsRepo {
  final AppSectionsDataSource _dataSource;

  AppSectionsRepoImpl(this._dataSource);

  @override
  Future<Result<UserEntity>> getUserData() async {
    final result = await _dataSource.getCurrentUserData();
    return _mapResult(result);
  }

  Result<UserEntity> _mapResult(Result<UserDto> result) {
    switch (result) {
      case Success<UserDto>():
        return Success(result.data.toEntity());
      case Failure<UserDto>():
        return Failure(result.errorMessage);
    }
  }

  @override
  Future<Result<void>> upLoadUserData({
    required String collectionPath,
    required String userId,
    required Map<String, dynamic> data,
  }) => _dataSource.upLoadUserData(
    collectionPath: collectionPath,
    userId: userId,
    data: data,
  );
}
