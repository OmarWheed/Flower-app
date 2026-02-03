import 'package:flower_app/features/home/data/models/best_seller_dto.dart';
import 'package:flower_app/features/home/data/models/best_seller_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BestSellerResponse - 100% Coverage', () {
    // Arrange
    final tBestSellerDto = BestSellerDto(
      iD: "1",
      title: "Flower A",
      slug: "flower-a",
      description: "Description",
      imgCover: "image.png",
      images: const ["img1.png"],
      price: 100,
      priceAfterDiscount: 90,
      quantity: 10,
      category: "Category",
      occasion: "Occasion",
      createdAt: "2024-01-01",
      updatedAt: "2024-01-01",
      v: 0,
      isSuperAdmin: false,
      sold: 10,
      rateAvg: 5,
      rateCount: 1,
      id: "1",
    );

    final tBestSellerResponse = BestSellerResponse(
      message: "Success",
      bestSeller: [tBestSellerDto],
    );

    final Map<String, dynamic> tJson = {
      "message": "Success",
      "bestSeller": [
        {
          "_id": "1",
          "title": "Flower A",
          "slug": "flower-a",
          "description": "Description",
          "imgCover": "image.png",
          "images": ["img1.png"],
          "price": 100,
          "priceAfterDiscount": 90,
          "quantity": 10,
          "category": "Category",
          "occasion": "Occasion",
          "createdAt": "2024-01-01",
          "updatedAt": "2024-01-01",
          "__v": 0,
          "isSuperAdmin": false,
          "sold": 10,
          "rateAvg": 5,
          "rateCount": 1,
          "id": "1",
        },
      ],
    };

    test('fromJson should return a valid model with all fields populated', () {
      // Act
      final result = BestSellerResponse.fromJson(tJson);

      // Assert
      expect(result.message, tBestSellerResponse.message);
      expect(result.bestSeller?.length, 1);
      expect(result.bestSeller?[0].title, tBestSellerDto.title);
    });

    test('toJson should return a JSON map containing all proper data', () {
      // Act
      final result = tBestSellerResponse.toJson();

      // Assert
      expect(result, equals(tJson));
    });

    test('should handle empty list for bestSeller', () {
      // Act
      final response = BestSellerResponse(message: "Empty", bestSeller: []);
      final json = response.toJson();

      // Assert
      expect(json['bestSeller'], isEmpty);
    });
  });
}
