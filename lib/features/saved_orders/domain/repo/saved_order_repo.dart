import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/saved_orders/domain/entity/saved_order_entity.dart';

abstract class SavedOrderRepo {
  Future<Result<List<SavedOrderEntity>>> getSavedOrders();
}
