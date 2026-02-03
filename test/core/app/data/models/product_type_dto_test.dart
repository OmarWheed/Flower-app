import 'package:flower_app/core/app/data/models/product_type_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductTypeDto', () {
    final tDate = DateTime.parse("2024-01-01T10:00:00.000Z");

    final tProductTypeDto = ProductTypeDto(
      id: "1",
      name: "Electronics",
      slug: "electronics",
      image: "image.png",
      createdAt: tDate,
      updatedAt: tDate,
      isSuperAdmin: false,
    );

    final Map<String, dynamic> tJson = {
      "_id": "1",
      "name": "Electronics",
      "slug": "electronics",
      "image": "image.png",
      "createdAt": "2024-01-01T10:00:00.000Z",
      "updatedAt": "2024-01-01T10:00:00.000Z",
      "isSuperAdmin": false,
    };

    test('fromJson should return a valid model', () {
      final result = ProductTypeDto.fromJson(tJson);
      expect(result, equals(tProductTypeDto));
    });

    test('toJson should return a JSON map containing proper data', () {
      final result = tProductTypeDto.toJson();
      expect(result, tJson);
    });

    test('should support value equality', () {
      final sameModel = ProductTypeDto(
        id: "1",
        name: "Electronics",
        slug: "electronics",
        image: "image.png",
        createdAt: tDate,
        updatedAt: tDate,
        isSuperAdmin: false,
      );
      expect(tProductTypeDto, equals(sameModel));
    });

    test('fromJson should handle null fields gracefully', () {
      final Map<String, dynamic> emptyJson = {};
      final result = ProductTypeDto.fromJson(emptyJson);

      expect(result.id, null);
      expect(result.isSuperAdmin, null);
    });
  });
}
