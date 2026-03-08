import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/saved_orders/data/data_sources/saved_order_data_source.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_order_response.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_orders_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SavedOrderDataSource)
class SavedOrderDataSourceImpl implements SavedOrderDataSource {
  final ApiClient _apiClient;

  SavedOrderDataSourceImpl(this._apiClient);

  @override
  Future<Result<List<SavedOrdersDto>>> getSavedOrders() {
    return executeApi<List<SavedOrdersDto>>(() async {
      final SavedOrderResponse savedOrderResponse = await _apiClient
          .getSavedOrders();
      return savedOrderResponse.ordersDto ?? [];
    });
  }
}
