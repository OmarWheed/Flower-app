import 'package:dio/dio.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/data/models/get_notifications_response_dto.dart';
import 'package:flower_app/features/profile/data/models/get_user_data_response.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';

abstract interface class ProfileRemoteDataSource {
  Future<Result<GetUserDataResponse>> getProfileData();
  Future<Result<GetUserDataResponse>> editProfile({
    required EditProfileRequest editProfileRequest,
  });
  Future<Result<UploadPhotoResponse>> uploadPhoto({
    required MultipartFile photo,
  });

  Future<Result<List<NotificationItemDTO>>> getNotifications({
    required String userId,
  });
}
