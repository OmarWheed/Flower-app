import 'package:flower_app/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/data/models/get_notifications_response_dto.dart';
import 'package:flower_app/features/profile/data/models/get_user_data_response.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<GetUserDataResponse>> getProfileData() {
    return executeApi(() => _apiClient.getProfileData());
  }

  @override
  Future<Result<GetUserDataResponse>> editProfile({
    required EditProfileRequest editProfileRequest,
  }) {
    return executeApi(
      () => _apiClient.editProfile(editProfileRequest: editProfileRequest),
    );
  }

  @override
  Future<Result<UploadPhotoResponse>> uploadPhoto({
    required MultipartFile photo,
  }) {
    return executeApi(() => _apiClient.uploadPhoto(photo));
  }

  @override
  Future<Result<List<NotificationItemDTO>>> getNotifications() async =>
      executeApi(() async {
        final response = await _apiClient.getNotifications();
        return response.notificationsDto ?? [];
      });
}
