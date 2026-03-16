import 'dart:io';

import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:flower_app/features/profile/domain/entity/about_us_entity.dart';
import 'package:flower_app/features/profile/domain/entity/notification_entity.dart';

abstract interface class ProfileRepo {
  Future<Result<UserEntity>> getProfileData();
  Future<Result<UserEntity>> editProfile({
    required EditProfileRequest editProfileRequest,
  });
  Future<Result<UploadPhotoResponse>> uploadPhoto({required File imageFile});

  Future<Result<AboutUsEntity>> getAboutUs();

  Future<Result<List<NotificationEntity>>> getNotifications({
    required String userId,
  });
}
