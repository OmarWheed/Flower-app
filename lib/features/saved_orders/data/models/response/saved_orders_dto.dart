import 'package:flower_app/features/saved_orders/data/models/response/saved_order_response.dart';
import 'package:flower_app/features/saved_orders/domain/entity/saved_order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'saved_orders_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SavedOrdersDto {
  @JsonKey(name: "shippingAddress")
  final ShippingAddress? shippingAddress;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final String? user;
  @JsonKey(name: "orderItems")
  final List<OrderItems>? orderItems;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "isPaid")
  final bool? isPaid;
  @JsonKey(name: "paidAt")
  final String? paidAt;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;
  @JsonKey(name: "__v")
  final int? V;

  SavedOrdersDto({
    this.shippingAddress,
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.paidAt,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.V,
  });

  factory SavedOrdersDto.fromJson(Map<String, dynamic> json) {
    return _$SavedOrdersDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SavedOrdersDtoToJson(this);
  }

  SavedOrderEntity toEntity() {
    return SavedOrderEntity(
      shippingAddress: shippingAddress,
      id: id,
      user: user,
      orderItems: orderItems,
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      paidAt: paidAt,
      isDelivered: isDelivered,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
      V: V,
    );
  }
}
