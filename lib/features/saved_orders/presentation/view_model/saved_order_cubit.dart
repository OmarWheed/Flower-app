import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/saved_orders/domain/entity/saved_order_entity.dart';
import 'package:flower_app/features/saved_orders/domain/usecases/get_user_order.dart';
import 'package:flower_app/features/saved_orders/presentation/view_model/saved_order_events.dart';
import 'package:flower_app/features/saved_orders/presentation/view_model/saved_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/orders_by_status.dart';

@injectable
// ignore: must_be_immutable
class SavedOrderCubit extends Cubit<SavedOrderState> with EquatableMixin {
  final SavedOrderUseCase _savedOrderUseCase;

  SavedOrderCubit(this._savedOrderUseCase) : super(const SavedOrderState());
  final StreamController<SavedOrdersUiEvent> _savedOrderUiEvent =
      StreamController.broadcast();

  Stream<SavedOrdersUiEvent> get savedOrdersUiEvent =>
      _savedOrderUiEvent.stream;

  @override
  List<Object> get props {
    return [state];
  }

  void doIntent(SavedOrdersEvents event) {
    switch (event) {
      case GetSavedOrdersEvents():
        _getSavedOrders();
    }
  }

  Future<void> _getSavedOrders() async {
    emit(
      state.copyWith(
        activeOrders: const BaseState(requestState: RequestState.loading),
        completedOrders: const BaseState(requestState: RequestState.loading),
      ),
    );

    final Result<OrdersByStatus> response = await _savedOrderUseCase
        .getOrdersByStatus();

    switch (response) {
      case Success<OrdersByStatus>():
        emit(
          state.copyWith(
            activeOrders: BaseState<List<SavedOrderEntity>>.loaded(
              response.data.active,
            ),
            completedOrders: BaseState<List<SavedOrderEntity>>.loaded(
              response.data.completed,
            ),
          ),
        );

      case Failure<OrdersByStatus>():
        emit(
          state.copyWith(
            activeOrders: BaseState<List<SavedOrderEntity>>.error(
              response.errorMessage,
            ),
            completedOrders: BaseState<List<SavedOrderEntity>>.error(
              response.errorMessage,
            ),
          ),
        );
    }
  }

  @override
  Future<void> close() {
    _savedOrderUiEvent.close();
    return super.close();
  }
}
