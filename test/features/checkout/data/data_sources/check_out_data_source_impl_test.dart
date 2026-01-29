import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/data_sources/check_out_data_source_impl.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/data/models/response/address_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/check_out_cash_response_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/check_out_order_response.dart';
import 'package:flower_app/features/checkout/data/models/response/order_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/session_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/user_addresses_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_out_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late CheckOutDataSourceImpl dataSource;
  late MockApiClient api;
  late SessionDto sessionDto;
  late AddressesDto addressesDto;
  late List<AddressesDto> addressesDtoList;
  late OrderDto orderDto;
  late CheckOutOrderRequest checkOutOrderRequest;
  late String exception;
  late CheckOutCashResponseDto checkOutCashResponseDto;
  late CheckOutCreditCardResponseDto checkOutCreditCardResponseDto;

  setUpAll(() {
    api = MockApiClient();
    dataSource = CheckOutDataSourceImpl(api);
    sessionDto = SessionDto(
      id: "id",
      object: "object",
      afterExpiration: "afterExpiration",
      allowPromotionCodes: "allowPromotionCodes",
      amountTotal: 0,
    );
    orderDto = OrderDto(
      createdAt: "createdAt",
      id: "id",
      updatedAt: "updatedAt",
      V: 0,
      orderNumber: "orderNumber",
      isPaid: false,
      isDelivered: false,
      orderItems: [OrderItems(price: 0, quantity: 0, id: "id")],
      paymentType: "paymentType",
      state: "state",
      totalPrice: 0,
      user: "user",
    );
    addressesDto = AddressesDto(
      street: "street",
      phone: "phone",
      city: "city",
      lat: "lat",
      long: "long",
      username: "username",
      id: "id",
    );
    addressesDtoList = [addressesDto, addressesDto];
    exception = "error";
    checkOutOrderRequest = CheckOutOrderRequest(
      shippingAddress: ShippingAddress(lat: "lk"),
    );
    checkOutCreditCardResponseDto = CheckOutCreditCardResponseDto(
      session: sessionDto,
    );
    checkOutCashResponseDto = CheckOutCashResponseDto(order: orderDto);
    checkOutCashResponseDto = CheckOutCashResponseDto(order: orderDto);
    provideDummy<Result<SessionDto>>(Success<SessionDto>(sessionDto));
    provideDummy<Result<OrderDto>>(Success<OrderDto>(orderDto));
    provideDummy<Result<List<AddressesDto>>>(
      Success<List<AddressesDto>>(addressesDtoList),
    );
  });
  group("test checkoutCreditCard data source ", () {
    test(
      'When i call checkoutCreditCard from DataSource it calls checkoutCreditCard from apiClient'
      " and returns SessionDto and Success result",
      () async {
        when(
          api.checkoutCreditCard(checkOutOrderRequest),
        ).thenAnswer((_) async => checkOutCreditCardResponseDto);

        final result = await dataSource.checkoutCreditCard(
          checkOutOrderRequest,
        );

        expect(result, isA<Success<SessionDto>>());
        expect((result as Success<SessionDto>).data, equals(sessionDto));
        verify(api.checkoutCreditCard(checkOutOrderRequest)).called(1);
        verifyNoMoreInteractions(api);
      },
    );

    test(
      'When i call checkoutCreditCard from DataSource it calls checkoutCreditCard from apiClient'
      " and returns Failure ",
      () async {
        when(
          api.checkoutCreditCard(checkOutOrderRequest),
        ).thenThrow(Exception(exception));

        final result = await dataSource.checkoutCreditCard(
          checkOutOrderRequest,
        );

        expect(result, isA<Failure<SessionDto>>());
        expect(
          (result as Failure<SessionDto>).errorMessage,
          contains(exception),
        );
        verify(api.checkoutCreditCard(checkOutOrderRequest)).called(1);
      },
    );
  });
  group("test checkoutCash data source ", () {
    test(
      'When i call checkoutCash from DataSource it calls checkoutCash from apiClient'
      " and returns OrderDto and Success result",
      () async {
        when(
          api.checkoutCash(checkOutOrderRequest),
        ).thenAnswer((_) async => checkOutCashResponseDto);

        final result = await dataSource.checkoutCash(checkOutOrderRequest);

        expect(result, isA<Success<OrderDto>>());
        expect((result as Success<OrderDto>).data, equals(orderDto));
        verify(api.checkoutCash(checkOutOrderRequest)).called(1);
        verifyNoMoreInteractions(api);
      },
    );

    test(
      'When i call checkoutCash from DataSource it calls checkoutCash from apiClient'
      " and returns Failure ",
      () async {
        when(
          api.checkoutCash(checkOutOrderRequest),
        ).thenThrow(Exception(exception));

        final result = await dataSource.checkoutCash(checkOutOrderRequest);

        expect(result, isA<Failure<OrderDto>>());
        expect((result as Failure<OrderDto>).errorMessage, contains(exception));
        verify(api.checkoutCash(checkOutOrderRequest)).called(1);
      },
    );
  });
  group("test getUserAddresses data source ", () {
    test(
      'When i call getUserAddresses from DataSource it calls getUserAddresses from apiClient'
      " and returns List<AddressesDto> and Success result",
      () async {
        when(api.getUserAddresses()).thenAnswer(
          (_) async => UserAddressesResponseDto(addresses: addressesDtoList),
        );

        final result = await dataSource.getUserAddresses();

        expect(result, isA<Success<List<AddressesDto>>>());
        expect(
          (result as Success<List<AddressesDto>>).data,
          equals(addressesDtoList),
        );
        verify(api.getUserAddresses()).called(1);
        verifyNoMoreInteractions(api);
      },
    );
  });
}
