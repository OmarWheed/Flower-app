import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/track_order/data/data_source/notification_data_source.dart';
import 'package:flower_app/features/track_order/data/data_source/track_order_data_source.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/domain/repo/track_order_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderRepo)
class TrackOrderRepoImpl implements TrackOrderRepo {
  final TrackOrderDataSource dataSource;
  final NotificationDataSource notificationDataSource;

  TrackOrderRepoImpl(this.dataSource, this.notificationDataSource);

  @override
  Stream<Result<ActiveOrderEntity>> listenToOrder({required String orderId}) {
    return dataSource.listenToOrder(orderId: orderId);
  }

  @override
  Future<Result<void>> sendOrderDeliveredNotification(
    ActiveOrderEntity order,
  ) async {
    if (order.driverToken.isEmpty) {
      return Failure('Driver token not available');
    }
    return notificationDataSource.sendNotification(
      targetToken: order.driverToken,
      title: 'Order Delivered',
      body: 'Customer confirmed the order was delivered.',
    );
  }
}
