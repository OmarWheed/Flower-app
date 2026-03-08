import 'package:flower_app/features/saved_orders/data/models/response/saved_order_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SavedOrderResponse Model Test', () {
    final mockJson = {
      "message": "success",
      "metadata": {
        "currentPage": 1,
        "totalPages": 3,
        "limit": 10,
        "totalItems": 25,
      },
      "orders": [
        {
          "_id": "order_1",
          "items": [
            {
              "_id": "item_1",
              "price": 100,
              "quantity": 2,
              "product": {
                "_id": "product_1",
                "title": "Flower Bouquet",
                "slug": "flower-bouquet",
                "description": "Nice flowers",
                "imgCover": "img.png",
                "images": ["1.png", "2.png"],
                "price": 150,
                "priceAfterDiscount": 120,
                "quantity": 10,
                "category": "flowers",
                "occasion": "birthday",
                "createdAt": "2024-01-01",
                "updatedAt": "2024-01-02",
                "__v": 0,
                "isSuperAdmin": false,
                "sold": 5,
                "rateAvg": 4,
                "rateCount": 10,
                "id": "product_1",
              },
            },
          ],
          "shippingAddress": {
            "street": "Main St",
            "city": "Cairo",
            "phone": "01000000000",
            "lat": "30.0",
            "long": "31.0",
          },
        },
      ],
    };

    test('fromJson should parse correctly', () {
      final response = SavedOrderResponse.fromJson(mockJson);

      expect(response.message, "success");
      expect(response.metadata?.currentPage, 1);
      expect(response.metadata?.totalPages, 3);
      expect(response.ordersDto, isNotNull);
      expect(response.ordersDto!.length, 1);
    });

    test('fromJson parses metadata correctly', () {
      final response = SavedOrderResponse.fromJson(mockJson);

      expect(response.metadata, isNotNull);
      expect(response.metadata?.currentPage, 1);
      expect(response.metadata?.totalPages, 3);
    });
  });

  group('ShippingAddress Model Test', () {
    test('fromJson / toJson works correctly', () {
      final json = {
        "street": "Main St",
        "city": "Cairo",
        "phone": "01000000000",
        "lat": "30.0",
        "long": "31.0",
      };

      final address = ShippingAddress.fromJson(json);

      expect(address.city, "Cairo");
      expect(address.phone, "01000000000");
      expect(address.toJson()['street'], "Main St");
    });
  });

  group('Product Model Test', () {
    test('Product serialization', () {
      final json = {
        "_id": "product_1",
        "title": "Flower Bouquet",
        "price": 150,
        "priceAfterDiscount": 120,
        "quantity": 10,
        "rateAvg": 4,
        "rateCount": 10,
        "id": "product_1",
      };

      final product = Product.fromJson(json);

      expect(product.id, "product_1");
      expect(product.priceAfterDiscount, 120);

      final toJson = product.toJson();
      expect(toJson['_id'], "product_1");
      expect(toJson['price'], 150);
    });
  });

  group('OrderItems Model Test', () {
    test('OrderItems parse correctly', () {
      final json = {
        "_id": "item_1",
        "price": 100,
        "quantity": 2,
        "product": {"_id": "product_1", "title": "Flower Bouquet"},
      };

      final item = OrderItems.fromJson(json);

      expect(item.id, "item_1");
      expect(item.quantity, 2);
      expect(item.product?.title, "Flower Bouquet");
    });
  });
}
