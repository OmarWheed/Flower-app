import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/saved_orders/data/data_sources/saved_order_data_source.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_order_response.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_orders_dto.dart';
import 'package:flower_app/features/saved_orders/data/repo/saved_order_repo_impl.dart';
import 'package:flower_app/features/saved_orders/domain/entity/saved_order_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'saved_order_repo_impl_test.mocks.dart';

@GenerateMocks([SavedOrderDataSource])
void main() {
  late SavedOrderRepoImpl repo;
  late MockSavedOrderDataSource dataSource;
  late SavedOrdersDto dto;
  late List<SavedOrdersDto> dtoList;
  late List<SavedOrderEntity> entityList;
  late SavedOrderEntity entity;
  late Exception e;
  setUp(() {
    dataSource = MockSavedOrderDataSource();
    repo = SavedOrderRepoImpl(dataSource);
    dto = SavedOrdersDto(shippingAddress: ShippingAddress(street: "street"));
    entity = SavedOrderEntity(
      shippingAddress: ShippingAddress(
        street: "street",
        city: "city",
        phone: "phone",
        lat: "lat",
        long: "long",
      ),
      id: "id",
    );
    entityList = [entity, entity];
    dtoList = [dto, dto];
    e = Exception("error");
    provideDummy<Result<List<SavedOrdersDto>>>(
      Success<List<SavedOrdersDto>>(dtoList),
    );
  });
  test(
    'getSavedOrders returns a success result with a list of saved orders ',
    () async {
      when(
        dataSource.getSavedOrders(),
      ).thenAnswer((_) async => Success<List<SavedOrdersDto>>(dtoList));
      final res =
          await repo.getSavedOrders() as Success<List<SavedOrderEntity>>;
      expect(
        res.data[0].shippingAddress?.street,
        equals(entityList[0].shippingAddress?.street),
      );
      expect(
        res.data[1].shippingAddress?.street,
        equals(entityList[1].shippingAddress?.street),
      );
      verify(dataSource.getSavedOrders()).called(1);
      verifyNoMoreInteractions(dataSource);
    },
  );
  test('getSavedOrders returns a failure result with an exception ', () async {
    when(
      dataSource.getSavedOrders(),
    ).thenAnswer((_) async => Failure<List<SavedOrdersDto>>(e.toString()));
    final res = await repo.getSavedOrders() as Failure<List<SavedOrderEntity>>;
    expect(res.errorMessage, equals(e.toString()));
    verify(dataSource.getSavedOrders()).called(1);
    verifyNoMoreInteractions(dataSource);
  });
}
