import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/domain/entity/notification_entity.dart';
import 'package:flower_app/features/profile/domain/usecases/get_notification_use_case.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/managers/notifications_view_contract.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/view_model/notifications_view_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notifications_view_model_test.mocks.dart';

@GenerateMocks([GetNotificationUseCase, FlutterSecureStorage])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late NotificationsViewModel viewModel;
  late MockGetNotificationUseCase getNotificationUseCase;
  late List<NotificationEntity> notifications;
  late MockFlutterSecureStorage secureStorage;
  setUp(() {
    secureStorage = MockFlutterSecureStorage();
    getNotificationUseCase = MockGetNotificationUseCase();
    when(secureStorage.read(key: 'userId')).thenAnswer((_) async => "1");

    viewModel = NotificationsViewModel(getNotificationUseCase, secureStorage);
    notifications = [
      const NotificationEntity(id: "1"),
      const NotificationEntity(id: "2"),
    ];
  });

  tearDown(() => viewModel.close());

  group('NotificationsViewModel', () {
    test('initial state is NotificationsViewState.initial()', () {
      expect(viewModel.state, NotificationsViewState.initial());
    });

    blocTest<NotificationsViewModel, NotificationsViewState>(
      'emits [loading, loaded] when FetchNotificationsIntent succeeds',
      build: () => viewModel,
      setUp: () {
        provideDummy<Result<List<NotificationEntity>>>(Success(notifications));
        when(
          getNotificationUseCase.call(userId: "1"),
        ).thenAnswer((_) async => Success(notifications));
      },
      act: (cubit) => cubit.doIntent(FetchNotificationsIntent()),
      expect: () => [
        NotificationsViewState(BaseState.loading()),
        NotificationsViewState(BaseState.loaded(notifications)),
      ],
      verify: (_) => verify(getNotificationUseCase.call(userId: "1")).called(1),
    );

    blocTest<NotificationsViewModel, NotificationsViewState>(
      'emits [loading, error] when FetchNotificationsIntent fails',
      build: () => viewModel,
      setUp: () {
        provideDummy<Result<List<NotificationEntity>>>(
          Failure('Something went wrong'),
        );
        when(getNotificationUseCase.call(userId: "1")).thenAnswer(
          (_) async =>
              Failure<List<NotificationEntity>>('Something went wrong'),
        );
      },
      act: (cubit) => cubit.doIntent(FetchNotificationsIntent()),
      expect: () => [
        NotificationsViewState(BaseState.loading()),
        NotificationsViewState(BaseState.error('Something went wrong')),
      ],
      verify: (_) => verify(getNotificationUseCase.call(userId: "1")).called(1),
    );
  });
}

// class MockSecureStorage extends Mock implements FlutterSecureStorage {}
