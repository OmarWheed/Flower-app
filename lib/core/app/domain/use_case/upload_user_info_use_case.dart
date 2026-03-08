import 'package:flower_app/core/app/domain/repositories/app_sections_repo.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadUserInfoUseCase {
  final AppSectionsRepo _appSectionsRepo;

  UploadUserInfoUseCase(this._appSectionsRepo);

  Future<Result<void>> call({
    required String collectionPath,
    required String userId,
    required Map<String, dynamic> data,
  }) => _appSectionsRepo.upLoadUserData(
    collectionPath: collectionPath,
    userId: userId,
    data: data,
  );
}
