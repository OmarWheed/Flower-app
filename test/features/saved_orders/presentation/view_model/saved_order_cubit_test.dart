import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/saved_orders/domain/entity/orders_by_status.dart';
import 'package:flower_app/features/saved_orders/domain/entity/saved_order_entity.dart';
import 'package:flower_app/features/saved_orders/domain/usecases/get_user_order.dart';
import 'package:flower_app/features/saved_orders/presentation/view_model/saved_order_cubit.dart';
import 'package:flower_app/features/saved_orders/presentation/view_model/saved_order_events.dart';
import 'package:flower_app/features/saved_orders/presentation/view_model/saved_order_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'saved_order_cubit_test.mocks.dart';

@GenerateMocks([SavedOrderUseCase])
void main() {
  provideDummy<Result<OrdersByStatus>>(
    Success(OrdersByStatus(active: [], completed: [])),
  );

  late MockSavedOrderUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockSavedOrderUseCase();
  });

  group('SavedOrderCubit bloc_test', () {
    blocTest<SavedOrderCubit, SavedOrderState>(
      'emits loading then loaded when getOrdersByStatus succeeds',
      build: () {
        when(mockUseCase.getOrdersByStatus()).thenAnswer(
          (_) async => Success(
            OrdersByStatus(
              active: [SavedOrderEntity(id: '1', state: 'active')],
              completed: [SavedOrderEntity(id: '2', state: 'completed')],
            ),
          ),
        );
        return SavedOrderCubit(mockUseCase);
      },
      act: (cubit) => cubit.doIntent(GetSavedOrdersEvents()),
      expect: () {
        var state = SavedOrderState(
          activeOrders: BaseState.loading(),
          completedOrders: BaseState.loading(),
        );
        return [
          state,
          state.copyWith(
            activeOrders: BaseState.loaded([
              SavedOrderEntity(id: '1', state: 'active'),
            ]),
            completedOrders: BaseState.loaded([
              SavedOrderEntity(id: '2', state: 'completed'),
            ]),
          ),
        ];
      },
      verify: (_) {
        verify(mockUseCase.getOrdersByStatus()).called(1);
        verifyNoMoreInteractions(mockUseCase);
      },
    );

    blocTest<SavedOrderCubit, SavedOrderState>(
      'emits loading then error when getOrdersByStatus fails',
      build: () {
        when(
          mockUseCase.getOrdersByStatus(),
        ).thenAnswer((_) async => Failure<OrdersByStatus>('network error'));
        return SavedOrderCubit(mockUseCase);
      },
      act: (cubit) => cubit.doIntent(GetSavedOrdersEvents()),
      expect: () => [
        SavedOrderState(
          activeOrders: BaseState.loading(),
          completedOrders: BaseState.loading(),
        ),
        SavedOrderState(
          activeOrders: BaseState.error('network error'),
          completedOrders: BaseState.error('network error'),
        ),
      ],
      verify: (_) {
        verify(mockUseCase.getOrdersByStatus()).called(1);
        verifyNoMoreInteractions(mockUseCase);
      },
    );
  });
}
