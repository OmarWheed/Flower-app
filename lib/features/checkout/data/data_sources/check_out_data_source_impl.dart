import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/checkout/data/data_sources/check_out_data_source.dart';
import 'package:flower_app/features/checkout/data/models/request/check_out_order_request.dart';
import 'package:flower_app/features/checkout/data/models/response/address_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/check_out_cash_response_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/check_out_order_response.dart';
import 'package:flower_app/features/checkout/data/models/response/order_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/session_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/user_addresses_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckOutDataSource)
class CheckOutDataSourceImpl implements CheckOutDataSource {
  final ApiClient _apiClient;

  CheckOutDataSourceImpl(this._apiClient);

  @override
  Future<Result<SessionDto>> checkoutCreditCard(
    CheckOutOrderRequest checkoutRequest,
  ) {
    return executeApi<SessionDto>(() async {
      final CheckOutCreditCardResponseDto checkOutOrderResponse =
          await _apiClient.checkoutCreditCard(checkoutRequest);
      return checkOutOrderResponse.session ?? SessionDto();
    });
  }

  @override
  Future<Result<OrderDto>> checkoutCash(CheckOutOrderRequest checkoutRequest) {
    return executeApi<OrderDto>(() async {
      final CheckOutCashResponseDto checkOutOrderResponse = await _apiClient
          .checkoutCash(checkoutRequest);
      return checkOutOrderResponse.order ?? OrderDto();
    });
  }

  @override
  Future<Result<List<AddressesDto>>> getUserAddresses() {
    return executeApi<List<AddressesDto>>(() async {
      final UserAddressesResponseDto userAddressesResponse = await _apiClient
          .getUserAddresses();
      return userAddressesResponse.addresses ?? [];
    });
  }
}
