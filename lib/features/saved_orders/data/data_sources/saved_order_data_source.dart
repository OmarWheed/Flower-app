import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_orders_dto.dart';

abstract class SavedOrderDataSource {
  Future<Result<List<SavedOrdersDto>>> getSavedOrders();
}
