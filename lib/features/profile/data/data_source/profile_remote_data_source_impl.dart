import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/data/models/get_notifications_response_dto.dart';
import 'package:flower_app/features/profile/data/models/get_user_data_response.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient _apiClient;
  final FirebaseFirestore _firestore;

  ProfileRemoteDataSourceImpl(this._apiClient, this._firestore);

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
  Future<Result<List<NotificationItemDTO>>> getNotifications({
    required String userId,
  }) {
    return executeApi(() async {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .get();

      final notifications = snapshot.docs.map((doc) {
        final data = doc.data();
        return NotificationItemDTO(
          recipient: data['recipient'] as String?,
          title: data['title'] as String?,
          body: data['body'] as String?,
          type: data['type'] as String?,
          priority: data['priority'] as String?,
          actionLink: data['actionLink'] as String?,
          relatedId: data['relatedId'] as String?,
          relatedModel: data['relatedModel'] as String?,
        );
      }).toList();

      return notifications;
    });
  }
}
