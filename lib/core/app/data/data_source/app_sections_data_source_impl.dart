import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/app/data/data_source/app_sections_data_source.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/services/firebase/firebase_store_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AppSectionsDataSource)
class AppSectionsDataSourceImpl implements AppSectionsDataSource {
  final ApiClient _apiClient;
  final FirebaseStoreService _firebaseStoreService;

  AppSectionsDataSourceImpl(this._apiClient, this._firebaseStoreService);

  @override
  Future<Result<UserDto>> getCurrentUserData() async => executeApi(() async {
    final response = await _apiClient.getCurrentUserData();
    return response.user ?? UserDto();
  });

  @override
  Future<Result<void>> upLoadUserData({
    required String collectionPath,
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    return executeApi(
      () async => _firebaseStoreService.set(
        collectionPath: collectionPath,
        userId: userId,
        data: data,
      ),
    );
  }
}
