import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/saved_orders/data/data_sources/saved_order_data_source.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_orders_dto.dart';
import 'package:flower_app/features/saved_orders/domain/entity/saved_order_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo/saved_order_repo.dart';

@Injectable(as: SavedOrderRepo)
class SavedOrderRepoImpl implements SavedOrderRepo {
  final SavedOrderDataSource dataSource;

  SavedOrderRepoImpl(this.dataSource);

  @override
  Future<Result<List<SavedOrderEntity>>> getSavedOrders() async {
    Result<List<SavedOrdersDto>> orderDto = await dataSource.getSavedOrders();
    switch (orderDto) {
      case Success<List<SavedOrdersDto>>():
        {
          final items = orderDto.data;
          final order = items.map((dto) => dto.toEntity()).toList();

          return Success(order);
        }
      case Failure<List<SavedOrdersDto>>():
        {
          return Failure(orderDto.errorMessage);
        }
    }
  }
}
