import 'package:equatable/equatable.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_order_response.dart';

class SavedOrderEntity with EquatableMixin {
  final ShippingAddress? shippingAddress;
  final String? id;
  final String? user;
  final List<OrderItems>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final String? paidAt;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  final int? V;

  SavedOrderEntity({
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
    this.shippingAddress,
  });

  @override
  List<Object?> get props => [shippingAddress];
}
