import 'package:flower_app/features/saved_orders/domain/entity/saved_order_entity.dart';

class OrdersByStatus {
  final List<SavedOrderEntity> active;
  final List<SavedOrderEntity> completed;

  OrdersByStatus({required this.active, required this.completed});
}
