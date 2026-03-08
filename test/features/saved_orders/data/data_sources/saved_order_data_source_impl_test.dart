import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/saved_orders/data/data_sources/saved_order_data_source_impl.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_order_response.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_orders_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'saved_order_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late SavedOrderDataSourceImpl dataSourceImpl;
  late MockApiClient mockApiClient;
  late Exception exception;

  setUpAll(() {
    mockApiClient = MockApiClient();
    dataSourceImpl = SavedOrderDataSourceImpl(mockApiClient);
    exception = Exception();
  });

  test('Test getSavedOrders with success', () async {
    SavedOrderResponse savedOrderResponse = SavedOrderResponse(message: "");
    when(
      mockApiClient.getSavedOrders(),
    ).thenAnswer((_) async => savedOrderResponse);
    final res =
        await dataSourceImpl.getSavedOrders() as Success<List<SavedOrdersDto>>;
    expect(res, isA<Success<List<SavedOrdersDto>>>());
    verify(mockApiClient.getSavedOrders()).called(1);
    verifyNoMoreInteractions(mockApiClient);
  });
  test('Test getSavedOrders with Failure', () async {
    when(mockApiClient.getSavedOrders()).thenThrow(exception);
    final res =
        await dataSourceImpl.getSavedOrders() as Failure<List<SavedOrdersDto>>;
    expect(res, isA<Failure<List<SavedOrdersDto>>>());
    expect(res.errorMessage, exception.toString());
    verify(mockApiClient.getSavedOrders()).called(1);
    verifyNoMoreInteractions(mockApiClient);
  });
}
