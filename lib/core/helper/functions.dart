// presentation/utils/order_display_helpers.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';

String? formatArrivalDate(DateTime? date) {
  if (date == null) return null;
  return DateFormat('dd MMM yyyy, HH:mm').format(date);
}

String? resolveDeliveryName(ActiveOrderEntity order) {
  if (order.driverName?.isNotEmpty == true) return order.driverName;
  if (order.userName.isNotEmpty) return order.userName;
  return null;
}
