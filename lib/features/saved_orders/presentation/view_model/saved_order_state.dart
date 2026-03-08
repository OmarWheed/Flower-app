import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/saved_orders/domain/entity/saved_order_entity.dart';

class SavedOrderState extends Equatable {
  final BaseState<List<SavedOrderEntity>>? activeOrders;
  final BaseState<List<SavedOrderEntity>>? completedOrders;

  const SavedOrderState({this.activeOrders, this.completedOrders});

  SavedOrderState copyWith({
    BaseState<List<SavedOrderEntity>>? activeOrders,
    BaseState<List<SavedOrderEntity>>? completedOrders,
  }) {
    return SavedOrderState(
      activeOrders: activeOrders ?? this.activeOrders,
      completedOrders: completedOrders ?? this.completedOrders,
    );
  }

  @override
  List<Object?> get props => [activeOrders, completedOrders];
}
