import 'package:flower_app/features/checkout/data/models/response/order_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check-out-cash-response-dto.g.dart';

@JsonSerializable()
class CheckOutCashResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "order")
  final OrderDto? order;

  CheckOutCashResponseDto({this.message, this.order});

  factory CheckOutCashResponseDto.fromJson(Map<String, dynamic> json) {
    return _$CheckOutCashResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CheckOutCashResponseDtoToJson(this);
  }
}
