import 'package:flower_app/core/error_handling/result.dart';

/// Sends FCM notification (e.g. when user confirms "Order Delivered").
abstract interface class NotificationDataSource {
  Future<Result<void>> sendNotification({
    required String targetToken,
    required String title,
    required String body,
  });
}
