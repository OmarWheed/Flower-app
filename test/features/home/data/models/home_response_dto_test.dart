import 'package:flower_app/core/app/data/models/product_type_dto.dart';
import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeResponseDto - 100% Coverage', () {
    final tDate = DateTime.parse("2024-01-01T10:00:00.000Z");

    // 1. Setup Nested Objects
    final tProduct = ProductsDto(
      id: "p1",
      title: "Classic Red Roses",
      slug: "classic-red-roses",
      description: "A bouquet of 12 premium red roses.",
      imgCover: "roses_cover.jpg",
      images: const ["rose1.jpg", "rose2.jpg"],
      price: 59.99,
      priceAfterDiscount: 49.99,
      quantity: 100,
      category: "Roses",
      occasion: "Anniversary",
      createdAt: tDate,
      updatedAt: tDate,
      v: 0,
      isSuperAdmin: false,
      sold: 45,
      rateAvg: 4.8,
      rateCount: 120,
      discount: 10.0,
      alternateId: "alt-p101",
    );

    final tCategory = ProductTypeDto(
      id: "c1",
      name: "Birthday Flowers",
      slug: "birthday-flowers",
      image: "birthday_icon.png",
      createdAt: tDate,
      updatedAt: tDate,
      isSuperAdmin: false,
    );

    // 2. Setup the Main DTO
    final tHomeResponseDto = HomeResponseDto(
      message: "Success",
      products: [tProduct],
      categories: [tCategory],
      bestSeller: [tProduct],
      occasions: [tCategory],
    );

    // 3. Setup the Expected JSON
    final Map<String, dynamic> tJson = {
      "message": "Success",
      "products": [tProduct.toJson()],
      "categories": [tCategory.toJson()],
      "bestSeller": [tProduct.toJson()],
      "occasions": [tCategory.toJson()],
    };

    test(
      'fromJson should return a valid model with all nested lists populated',
      () {
        // Act
        final result = HomeResponseDto.fromJson(tJson);

        // Assert
        expect(result, equals(tHomeResponseDto));
        expect(result.products![0].id, "p1");
        expect(result.categories![0].id, "c1");
      },
    );

    test('toJson should return a Map with 100% field coverage', () {
      // Arrange
      final tHomeResponseDto = HomeResponseDto(
        message: "Success",
        products: [tProduct],
        categories: [tCategory],
        bestSeller: [tProduct],
        occasions: [tCategory],
      );

      // Act
      final result = tHomeResponseDto.toJson();

      // Assert
      expect(result['message'], "Success");

      // Verify list lengths
      expect(result['products'], hasLength(1));
      expect(result['categories'], hasLength(1));
      expect(result['bestSeller'], hasLength(1));
      expect(result['occasions'], hasLength(1));

      // Verify nested field mapping (ensures explicitToJson worked)
      expect(result['products'][0]['_id'], "p1");
      expect(result['categories'][0]['name'], "Birthday Flowers");
      expect(result['bestSeller'][0]['price'], 59.99);
      expect(result['occasions'][0]['slug'], "birthday-flowers");
    });

    test('should support value equality via Equatable', () {
      final duplicate = HomeResponseDto(
        message: "Success",
        products: [tProduct],
        categories: [tCategory],
        bestSeller: [tProduct],
        occasions: [tCategory],
      );

      expect(tHomeResponseDto, equals(duplicate));
    });
  });
}
