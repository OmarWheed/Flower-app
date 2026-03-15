import 'dart:async';

import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/domain/repo/track_order_repo.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrackOrderViewModel extends Cubit<TrackOrderStates> {
  final TrackOrderRepo trackOrderRepo;

  StreamSubscription? _subscription;
  final _uiEventsController = StreamController<TrackOrderUIEvents>.broadcast();
  Stream<TrackOrderUIEvents> get uiEventsStream => _uiEventsController.stream;

  TrackOrderViewModel(this.trackOrderRepo) : super(TrackOrderStates.initial());

  void doIntent(Intent intent) {
    switch (intent) {
      case ListenToOrderIntent():
        _listenToOrder(intent.orderId);
      case DisposeOrderListenerIntent():
        _cancelSubscription();
      case ShowMapIntent():
        emit(state.copyWith(showMap: true));
      case ShowOrderDetailsIntent():
        emit(state.copyWith(showMap: false));
      case OrderDeliveredIntent():
        _onOrderDelivered();
    }
  }

  void _onOrderDelivered() {
    _cancelSubscription();
    _uiEventsController.add(NavigatePopScreen());
  }

  void _listenToOrder(String orderId) {
    emit(state.copyWith(orderState: state.orderState.loading));
    _cancelSubscription();

    _subscription = trackOrderRepo
        .listenToOrder(orderId: orderId)
        .listen(
          (result) {
            switch (result) {
              case Success<ActiveOrderEntity>():
                emit(
                  state.copyWith(
                    orderState: state.orderState.loaded(result.data),
                  ),
                );
              case Failure<ActiveOrderEntity>():
                emit(
                  state.copyWith(
                    orderState: state.orderState.error(result.errorMessage),
                  ),
                );
            }
          },
          onError: (e, st) {
            emit(
              state.copyWith(orderState: state.orderState.error(e.toString())),
            );
          },
          cancelOnError: false,
        );
  }

  void _cancelSubscription() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  Future<void> close() {
    _uiEventsController.close();
    _cancelSubscription();
    return super.close();
  }
}
