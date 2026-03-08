import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/profile/domain/entity/notification_entity.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/managers/notifications_view_contract.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationsViewState', () {
    test('constructor assigns notificationsEntitiesState', () {
      final state = BaseState<List<NotificationEntity>>.init();

      final viewState = NotificationsViewState(state);

      expect(viewState.notificationsEntitiesState, state);
    });

    test('initial() creates state with BaseState.init()', () {
      final viewState = NotificationsViewState.initial();

      expect(viewState.notificationsEntitiesState, BaseState.init());
    });

    test(
      'copyWith updates notificationsEntitiesState when value is provided',
      () {
        final initialState = NotificationsViewState.initial();
        final loadingState = BaseState<List<NotificationEntity>>.loading();

        final newState = initialState.copyWith(loadingState);

        expect(newState.notificationsEntitiesState, loadingState);
      },
    );

    test('copyWith keeps old value when null is passed', () {
      final initialState = NotificationsViewState.initial();

      final newState = initialState.copyWith(null);

      expect(
        newState.notificationsEntitiesState,
        initialState.notificationsEntitiesState,
      );
    });

    test('copyWith returns a new instance (immutability)', () {
      final initialState = NotificationsViewState.initial();

      final newState = initialState.copyWith(
        BaseState<List<NotificationEntity>>.loading(),
      );

      expect(identical(newState, initialState), false);
    });

    test('states with same props are equal (Equatable)', () {
      final state1 = NotificationsViewState(BaseState.init());

      final state2 = NotificationsViewState(BaseState.init());

      expect(state1, equals(state2));
    });

    test('states with different props are not equal', () {
      final state1 = NotificationsViewState(BaseState.init());

      final state2 = NotificationsViewState(BaseState.loading());

      expect(state1, isNot(equals(state2)));
    });
  });
}
