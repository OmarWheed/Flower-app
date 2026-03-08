import 'package:flower_app/features/saved_orders/domain/entity/orders_by_status.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error_handling/result.dart';
import '../entity/saved_order_entity.dart';
import '../repo/saved_order_repo.dart';

@injectable
class SavedOrderUseCase {
  final SavedOrderRepo savedOrderRepo;

  SavedOrderUseCase(this.savedOrderRepo);

  Future<Result<List<SavedOrderEntity>>> getSavedOrders() {
    return savedOrderRepo.getSavedOrders();
  }

  Future<Result<OrdersByStatus>> getOrdersByStatus() async {
    final response = await savedOrderRepo.getSavedOrders();

    switch (response) {
      case Success<List<SavedOrderEntity>>():
        final orders = response.data;

        final activeOrders = orders.where((order) {
          return order.state != "completed";
        }).toList();

        final completedOrders = orders.where((order) {
          return order.state == "completed";
        }).toList();

        return Success(
          OrdersByStatus(active: activeOrders, completed: completedOrders),
        );

      case Failure<List<SavedOrderEntity>>():
        return Failure(response.errorMessage);
    }
  }
}
