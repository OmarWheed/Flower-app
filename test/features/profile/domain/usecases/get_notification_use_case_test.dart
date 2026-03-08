import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/domain/entity/notification_entity.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:flower_app/features/profile/domain/usecases/get_notification_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_notification_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late ProfileRepo profileRepo;
  late GetNotificationUseCase getNotificationUseCase;

  setUp(() {
    profileRepo = MockProfileRepo();
    getNotificationUseCase = GetNotificationUseCase(profileRepo);
  });

  test(
    "When getNotification called it's called repo to getNotifications with no more"
    "interactions and return the result with no modifications",
    () async {
      List<NotificationEntity> notifications = [];
      provideDummy<Result<List<NotificationEntity>>>(Success(notifications));
      when(profileRepo.getNotifications()).thenAnswer(
        (_) async => Success<List<NotificationEntity>>(notifications),
      );

      await getNotificationUseCase.call();

      verify(profileRepo.getNotifications()).called(1);
      verifyNoMoreInteractions(profileRepo);
    },
  );
}
