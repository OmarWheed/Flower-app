import 'package:flower_app/features/home/data/models/best_seller_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BestSellerDto', () {
    // Arrange
    final tBestSellerDto = BestSellerDto(
      iD: "mongo_id_123",
      title: "Best Selling Flower",
      slug: "best-selling-flower",
      description: "A top-rated flower bouquet.",
      imgCover: "cover_image.png",
      images: ["image1.png", "image2.png"],
      price: 100,
      priceAfterDiscount: 80,
      quantity: 50,
      category: "Flowers",
      occasion: "Birthday",
      createdAt: "2024-01-01T10:00:00Z",
      updatedAt: "2024-01-01T12:00:00Z",
      v: 1,
      isSuperAdmin: true,
      sold: 150,
      rateAvg: 5,
      rateCount: 200,
      id: "normal_id_456",
    );

    final Map<String, dynamic> tJson = {
      "_id": "mongo_id_123",
      "title": "Best Selling Flower",
      "slug": "best-selling-flower",
      "description": "A top-rated flower bouquet.",
      "imgCover": "cover_image.png",
      "images": ["image1.png", "image2.png"],
      "price": 100,
      "priceAfterDiscount": 80,
      "quantity": 50,
      "category": "Flowers",
      "occasion": "Birthday",
      "createdAt": "2024-01-01T10:00:00Z",
      "updatedAt": "2024-01-01T12:00:00Z",
      "__v": 1,
      "isSuperAdmin": true,
      "sold": 150,
      "rateAvg": 5,
      "rateCount": 200,
      "id": "normal_id_456",
    };

    test(
      'fromJson should return a valid model when all fields are populated',
      () {
        // Act
        final result = BestSellerDto.fromJson(tJson);

        // Assert
        expect(result.iD, tBestSellerDto.iD);
        expect(result.title, tBestSellerDto.title);
        expect(result.slug, tBestSellerDto.slug);
        expect(result.description, tBestSellerDto.description);
        expect(result.imgCover, tBestSellerDto.imgCover);
        expect(result.images, tBestSellerDto.images);
        expect(result.price, tBestSellerDto.price);
        expect(result.priceAfterDiscount, tBestSellerDto.priceAfterDiscount);
        expect(result.quantity, tBestSellerDto.quantity);
        expect(result.category, tBestSellerDto.category);
        expect(result.occasion, tBestSellerDto.occasion);
        expect(result.createdAt, tBestSellerDto.createdAt);
        expect(result.updatedAt, tBestSellerDto.updatedAt);
        expect(result.v, tBestSellerDto.v);
        expect(result.isSuperAdmin, tBestSellerDto.isSuperAdmin);
        expect(result.sold, tBestSellerDto.sold);
        expect(result.rateAvg, tBestSellerDto.rateAvg);
        expect(result.rateCount, tBestSellerDto.rateCount);
        expect(result.id, tBestSellerDto.id);
      },
    );

    test('toJson should return a JSON map containing all fields', () {
      // Act
      final result = tBestSellerDto.toJson();

      // Assert
      expect(result, equals(tJson));
    });

    test(
      'should verify field mapping specifically for odd keys (_id, __v)',
      () {
        // Act
        final result = tBestSellerDto.toJson();

        // Assert
        expect(result.containsKey('_id'), true);
        expect(result.containsKey('__v'), true);
        expect(result['_id'], "mongo_id_123");
        expect(result['__v'], 1);
      },
    );
  });
}
