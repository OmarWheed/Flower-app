import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductsDto', () {
    final tDate = DateTime.parse("2024-01-01T10:00:00.000Z");

    final tProductsDto = ProductsDto(
      id: "101",
      title: "Red Roses Bouquet",
      slug: "red-roses-bouquet",
      description: "A beautiful bouquet of fresh red roses.",
      imgCover: "cover.jpg",
      images: const ["img1.jpg", "img2.jpg"],
      price: 50.0,
      priceAfterDiscount: 45.0,
      quantity: 10,
      category: "Flowers",
      occasion: "Anniversary",
      createdAt: tDate,
      updatedAt: tDate,
      v: 0,
      isSuperAdmin: false,
      sold: 5,
      rateAvg: 4.5,
      rateCount: 20,
      discount: 10.0,
      alternateId: "alt-101",
    );

    final Map<String, dynamic> tJson = {
      "_id": "101",
      "title": "Red Roses Bouquet",
      "slug": "red-roses-bouquet",
      "description": "A beautiful bouquet of fresh red roses.",
      "imgCover": "cover.jpg",
      "images": ["img1.jpg", "img2.jpg"],
      "price": 50.0,
      "priceAfterDiscount": 45.0,
      "quantity": 10,
      "category": "Flowers",
      "occasion": "Anniversary",
      "createdAt": tDate.toIso8601String(),
      "updatedAt": tDate.toIso8601String(),
      "__v": 0,
      "isSuperAdmin": false,
      "sold": 5,
      "rateAvg": 4.5,
      "rateCount": 20,
      "discount": 10.0,
      "alternateId": "alt-101",
    };

    test('toJson should convert all fields into the correct Map', () {
      // Act
      final result = tProductsDto.toJson();

      // Assert
      expect(result, equals(tJson));
    });

    test('fromJson should correctly map all JSON keys to the object', () {
      // Act
      final result = ProductsDto.fromJson(tJson);

      // Assert
      expect(result, equals(tProductsDto));
    });

    test('Equatable should confirm all fields match for equality', () {
      // Create a second instance with identical data
      final tProductsDtoCopy = ProductsDto(
        id: "101",
        title: "Red Roses Bouquet",
        slug: "red-roses-bouquet",
        description: "A beautiful bouquet of fresh red roses.",
        imgCover: "cover.jpg",
        images: const ["img1.jpg", "img2.jpg"],
        price: 50.0,
        priceAfterDiscount: 45.0,
        quantity: 10,
        category: "Flowers",
        occasion: "Anniversary",
        createdAt: tDate,
        updatedAt: tDate,
        v: 0,
        isSuperAdmin: false,
        sold: 5,
        rateAvg: 4.5,
        rateCount: 20,
        discount: 10.0,
        alternateId: "alt-101",
      );

      expect(tProductsDto, equals(tProductsDtoCopy));
    });

    test('fromJson should handle double/int conversion for rateAvg', () {
      final Map<String, dynamic> jsonWithIntRate = {"rateAvg": 4};

      final result = ProductsDto.fromJson(jsonWithIntRate);

      expect(result.rateAvg, 4.0);
    });

    test('should handle empty or null images list', () {
      final json = {"images": null};
      final result = ProductsDto.fromJson(json);

      expect(result.images, null);
    });
  });
}
