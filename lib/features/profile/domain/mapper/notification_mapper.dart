import 'package:flower_app/features/profile/data/models/get_notifications_response_dto.dart';
import 'package:flower_app/features/profile/domain/entity/notification_entity.dart';

extension NotificationMapper on NotificationItemDTO {
  NotificationEntity toEntity() => NotificationEntity(
    id: recipient ?? "",
    title: title ?? "",
    body: body ?? "",
  );
}
