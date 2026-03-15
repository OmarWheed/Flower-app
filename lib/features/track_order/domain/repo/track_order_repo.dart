import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';

abstract interface class TrackOrderRepo {
  Stream<Result<ActiveOrderEntity>> listenToOrder({required String orderId});
}
