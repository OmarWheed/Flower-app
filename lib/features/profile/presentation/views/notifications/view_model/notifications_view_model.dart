import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/domain/entity/notification_entity.dart';
import 'package:flower_app/features/profile/domain/usecases/get_notification_use_case.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/managers/notifications_view_contract.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationsViewModel extends Cubit<NotificationsViewState> {
  final GetNotificationUseCase _getNotificationUseCase;

  NotificationsViewModel(this._getNotificationUseCase)
    : super(NotificationsViewState.initial());

  void doIntent(NotificationsViewIntent intent) {
    switch (intent) {
      case FetchNotificationsIntent():
        _fetchNotifications();
    }
  }

  _fetchNotifications() async {
    emit(state.copyWith(BaseState.loading()));
    var result = await _getNotificationUseCase.call();
    switch (result) {
      case Success<List<NotificationEntity>>():
        emit(state.copyWith(BaseState.loaded(result.data)));
      case Failure<List<NotificationEntity>>():
        emit(state.copyWith(BaseState.error(result.errorMessage)));
    }
  }
}
