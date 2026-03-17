import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';

class TrackOrderStates extends Equatable {
  final BaseState<ActiveOrderEntity> orderState;
  final bool showMap;

  const TrackOrderStates({required this.orderState, this.showMap = false});

  factory TrackOrderStates.initial() =>
      TrackOrderStates(orderState: BaseState.init());

  TrackOrderStates copyWith({
    BaseState<ActiveOrderEntity>? orderState,
    BaseState<void>? sendOrderDeliveredState,
    bool? showMap,
  }) {
    return TrackOrderStates(
      orderState: orderState ?? this.orderState,
      showMap: showMap ?? this.showMap,
    );
  }

  @override
  List<Object?> get props => [orderState, showMap];
}
