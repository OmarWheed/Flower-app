import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/profile/domain/entity/notification_entity.dart';

final class NotificationsViewState with EquatableMixin {
  final BaseState<List<NotificationEntity>> notificationsEntitiesState;

  const NotificationsViewState(this.notificationsEntitiesState);

  factory NotificationsViewState.initial() =>
      NotificationsViewState(BaseState.init());

  NotificationsViewState copyWith(BaseState<List<NotificationEntity>>? state) =>
      NotificationsViewState(state ?? notificationsEntitiesState);

  @override
  List<Object?> get props => [notificationsEntitiesState];
}

sealed class NotificationsViewIntent {}

class FetchNotificationsIntent extends NotificationsViewIntent {}
