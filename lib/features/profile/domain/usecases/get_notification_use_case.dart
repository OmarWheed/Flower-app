import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/domain/entity/notification_entity.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationUseCase {
  final ProfileRepo _profileRepo;

  GetNotificationUseCase(this._profileRepo);

  Future<Result<List<NotificationEntity>>> call({required String userId}) =>
      _profileRepo.getNotifications(userId: userId);
}
