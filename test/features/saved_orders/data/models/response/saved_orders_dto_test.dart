import 'package:flower_app/features/saved_orders/data/models/response/saved_order_response.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_orders_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SavedOrdersDto dto;
  test('test toEntity method in SavedOrdersDto with valid data', () {
    dto = SavedOrdersDto(
      shippingAddress: ShippingAddress(
        street: "street",
        city: "city",
        phone: "phone",
        lat: "lat",
        long: "long",
      ),
      id: "id",
      user: "user",
    );
    final res = dto.toEntity();
    expect(res.shippingAddress?.street, "street");
    expect(res.shippingAddress?.city, "city");
    expect(res.shippingAddress?.phone, "phone");
    expect(res.shippingAddress?.lat, "lat");
    expect(res.shippingAddress?.long, "long");
    expect(res.id, "id");
    expect(res.user, "user");
  });
  test('test toEntity method in SavedOrdersDto with null  data', () {
    dto = SavedOrdersDto(
      shippingAddress: ShippingAddress(
        street: null,
        city: null,
        phone: null,
        lat: null,
        long: null,
      ),
      id: null,
      user: null,
    );
    final res = dto.toEntity();
    expect(res.shippingAddress?.street, isNull);
    expect(res.shippingAddress?.city, isNull);
    expect(res.shippingAddress?.phone, isNull);
    expect(res.shippingAddress?.lat, isNull);
    expect(res.shippingAddress?.long, isNull);
    expect(res.id, isNull);
    expect(res.user, isNull);
  });
  test('test toEntity method in SavedOrdersDto with empty data', () {
    dto = SavedOrdersDto(
      shippingAddress: ShippingAddress(
        street: "",
        city: "",
        phone: "",
        lat: "",
        long: "",
      ),
    );
    final res = dto.toEntity();
    expect(res.shippingAddress?.street, isEmpty);
    expect(res.shippingAddress?.city, isEmpty);
    expect(res.shippingAddress?.phone, isEmpty);
    expect(res.shippingAddress?.lat, isEmpty);
    expect(res.shippingAddress?.long, isEmpty);
  });
  test('test fromJson method in SavedOrdersDto', () {
    final json = {
      "shippingAddress": {
        "street": "street",
        "city": "city",
        "phone": "phone",
        "lat": "lat",
        "long": "long",
      },
      "user": "user",
    };
    final res = SavedOrdersDto.fromJson(json);
    expect(res.shippingAddress?.street, "street");
    expect(res.shippingAddress?.city, "city");
    expect(res.shippingAddress?.phone, "phone");
    expect(res.shippingAddress?.lat, "lat");

    expect(res.shippingAddress?.long, "long");
    expect(res.user, "user");
  });
  test('test toJson method in SavedOrdersDto', () {
    dto = SavedOrdersDto(
      shippingAddress: ShippingAddress(
        street: "street",
        city: "city",
        phone: "phone",
        lat: "lat",
        long: "long",
      ),
      user: "user",
    );
    final res = dto.toJson();
    expect(res["shippingAddress"]["street"], "street");
    expect(res["shippingAddress"]["city"], "city");
    expect(res["shippingAddress"]["phone"], "phone");
    expect(res["shippingAddress"]["lat"], "lat");
    expect(res["shippingAddress"]["long"], "long");
    expect(res["user"], "user");
  });
}
