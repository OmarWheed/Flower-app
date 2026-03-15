enum OrderStatus { accepted, picked, outForDelivery, arrived, delivered }

extension OrderStatusX on OrderStatus {
  static OrderStatus fromString(String? value) {
    switch (value?.toLowerCase().trim()) {
      case 'accepted':
        return OrderStatus.accepted;
      case 'picked':
        return OrderStatus.picked;
      case 'outfordelivery':
      case 'out_for_delivery':
        return OrderStatus.outForDelivery;
      case 'arrived':
        return OrderStatus.arrived;
      case 'delivered':
        return OrderStatus.delivered;
      default:
        return OrderStatus.accepted;
    }
  }

  int get stepIndex {
    switch (this) {
      case OrderStatus.accepted:
        return 0;
      case OrderStatus.picked:
        return 1;
      case OrderStatus.outForDelivery:
        return 2;
      case OrderStatus.arrived:
        return 3;
      case OrderStatus.delivered:
        return 4;
    }
  }

  bool get isDelivered => this == OrderStatus.delivered;

  bool get isPickedUp =>
      this == OrderStatus.picked ||
      this == OrderStatus.outForDelivery ||
      this == OrderStatus.arrived ||
      this == OrderStatus.delivered;
}

/// Step item for the order progress stepper UI.
class OrderStepEntity {
  final String title;
  final String date;

  const OrderStepEntity({required this.title, required this.date});

  factory OrderStepEntity.fromMap(Map<String, dynamic> map) {
    return OrderStepEntity(
      title: map['title'] as String? ?? '',
      date: map['date'] as String? ?? '',
    );
  }
}

/// Default steps matching the 5 statuses (accepted → delivered).
List<OrderStepEntity> defaultOrderSteps() => const [
  OrderStepEntity(title: 'Received your order', date: ''),
  OrderStepEntity(title: 'Preparing your order', date: ''),
  OrderStepEntity(title: 'Out for delivery', date: ''),
  OrderStepEntity(title: 'Arrived', date: ''),
  OrderStepEntity(title: 'Delivered', date: ''),
];
