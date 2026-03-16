import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';

class TrackOrderStates extends Equatable {
  final BaseState<ActiveOrderEntity> orderState;
  final bool showMap;
  /// Override for destination (e.g. from order's shipping address when Firestore has no destLat/destLng).
  final double? destLatOverride;
  final double? destLngOverride;

  const TrackOrderStates({
    required this.orderState,
    this.showMap = false,
    this.destLatOverride,
    this.destLngOverride,
  });

  factory TrackOrderStates.initial() =>
      TrackOrderStates(orderState: BaseState.init());

  TrackOrderStates copyWith({
    BaseState<ActiveOrderEntity>? orderState,
    bool? showMap,
    double? destLatOverride,
    double? destLngOverride,
  }) {
    return TrackOrderStates(
      orderState: orderState ?? this.orderState,
      showMap: showMap ?? this.showMap,
      destLatOverride: destLatOverride ?? this.destLatOverride,
      destLngOverride: destLngOverride ?? this.destLngOverride,
  );
  }

  @override
  List<Object?> get props => [orderState, showMap, destLatOverride, destLngOverride];
}
