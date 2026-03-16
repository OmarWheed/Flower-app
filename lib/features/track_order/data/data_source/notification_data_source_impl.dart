import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/requests/send_notification_request.dart';
import 'package:flower_app/core/constants/constants.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/features/track_order/data/data_source/notification_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationDataSource)
class NotificationDataSourceImpl implements NotificationDataSource {
  final ApiClient _apiClient;

  NotificationDataSourceImpl(this._apiClient);

  @override
  Future<Result<void>> sendNotification({
    required String targetToken,
    required String title,
    required String body,
  }) async {
    final fcmAccessToken =
        await AppLocalStorage.getString(key: AppConstants.fcmAccessToken);
    final authorization = 'Bearer $fcmAccessToken';

    return executeApi<void>(() async {
      await _apiClient.sendNotification(
        notificationDto: SendNotificationRequest(
          targetToken: targetToken,
          title: title,
          body: body,
        ),
        authorization: authorization,
      );
    });
  }
}
