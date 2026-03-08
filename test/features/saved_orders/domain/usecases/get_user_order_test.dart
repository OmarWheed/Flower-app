import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/saved_orders/domain/entity/orders_by_status.dart';
import 'package:flower_app/features/saved_orders/domain/entity/saved_order_entity.dart';
import 'package:flower_app/features/saved_orders/domain/repo/saved_order_repo.dart';
import 'package:flower_app/features/saved_orders/domain/usecases/get_user_order.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_order_test.mocks.dart';

@GenerateMocks([SavedOrderRepo])
void main() {
  late SavedOrderUseCase useCase;
  late MockSavedOrderRepo repo;
  late List<SavedOrderEntity> orders;

  setUp(() {
    repo = MockSavedOrderRepo();
    useCase = SavedOrderUseCase(repo);

    orders = [SavedOrderEntity(id: '1'), SavedOrderEntity(id: '1')];

    provideDummy<Result<List<SavedOrderEntity>>>(
      Success<List<SavedOrderEntity>>(orders),
    );
    provideDummy<Result<List<SavedOrderEntity>>>(
      Success<List<SavedOrderEntity>>(const []),
    );
  });

  test('test call getSavedOrders', () async {
    when(
      repo.getSavedOrders(),
    ).thenAnswer((_) async => Success<List<SavedOrderEntity>>(orders));

    final res = await useCase.getSavedOrders();

    expect(
      (res as Success<List<SavedOrderEntity>>).data[0].id,
      equals(orders[0].id),
    );
  });

  test(
    'getOrdersByStatus returns active and completed orders when repo returns success',
    () async {
      // arrange
      final orders = [
        SavedOrderEntity(id: '1', state: "active"),
        SavedOrderEntity(id: '2', state: 'completed'),
        SavedOrderEntity(id: '3', state: "active"),
        SavedOrderEntity(id: '4', state: 'completed'),
      ];

      when(
        repo.getSavedOrders(),
      ).thenAnswer((_) async => Success<List<SavedOrderEntity>>(orders));

      // act
      final result = await useCase.getOrdersByStatus();

      // assert
      expect(result, isA<Success<OrdersByStatus>>());
      final data = (result as Success<OrdersByStatus>).data;

      expect(data.active.length, 2);
      expect(data.completed.length, 2);

      expect(data.active.every((o) => o.state != 'completed'), true);
      expect(data.completed.every((o) => o.state == 'completed'), true);

      verify(repo.getSavedOrders()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );

  test('getOrdersByStatus treats null state as active order', () async {
    final orders = [
      SavedOrderEntity(id: '1', state: null), // الطلب نشط
      SavedOrderEntity(id: '2', state: 'completed'), // الطلب مكتمل
    ];

    when(
      repo.getSavedOrders(),
    ).thenAnswer((_) async => Success<List<SavedOrderEntity>>(orders));

    final result = await useCase.getOrdersByStatus();
    final data = (result as Success<OrdersByStatus>).data;

    expect(data.active.length, 1);
    expect(data.completed.length, 1);
    expect(data.active.first.id, '1');

    verify(repo.getSavedOrders()).called(1);
    verifyNoMoreInteractions(repo);
  });

  test('getOrdersByStatus returns failure when repo returns failure', () async {
    const errorMessage = 'network error';

    when(
      repo.getSavedOrders(),
    ).thenAnswer((_) async => Failure<List<SavedOrderEntity>>(errorMessage));

    final result = await useCase.getOrdersByStatus();

    expect(result, isA<Failure<OrdersByStatus>>());
    expect((result as Failure).errorMessage, equals(errorMessage));

    verify(repo.getSavedOrders()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
