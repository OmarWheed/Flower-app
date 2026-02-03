import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/core/app/data/models/product_response.dart';
import 'package:flower_app/core/app/data/models/meta_data.dart';
import 'package:flower_app/core/app/data/models/products_dto.dart';

void main() {
  group('ProductResponse', () {
    test('creates ProductResponse with all fields', () {
      final metadata = Metadata(
        currentPage: 1,
        totalPages: 2,
        limit: 10,
        totalItems: 20,
      );

      final products = [
        const ProductsDto(id: "1", title: 'Rose'),
        const ProductsDto(id: "2", title: 'Tulip'),
      ];

      final response = ProductResponse(
        message: 'Success',
        metadata: metadata,
        productsDto: products,
      );

      expect(response.message, 'Success');
      expect(response.metadata, metadata);
      expect(response.productsDto, products);
    });

    test('fromJson parses full response correctly', () {
      final json = {
        'message': 'Success',
        'metadata': {
          'currentPage': 1,
          'totalPages': 1,
          'limit': 10,
          'totalItems': 2,
        },
        'products': [
          {'id': "1", 'title': 'Rose'},
          {'id': "2", 'title': 'Tulip'},
        ],
      };

      final response = ProductResponse.fromJson(json);

      expect(response.message, 'Success');
      expect(response.metadata?.currentPage, 1);
      expect(response.metadata?.totalItems, 2);
      expect(response.productsDto?.length, 2);
      expect(response.productsDto?.first.title, 'Rose');
    });

    test('toJson converts ProductResponse to correct map', () {
      final response = ProductResponse(
        message: 'OK',
        metadata: Metadata(
          currentPage: 2,
          totalPages: 3,
          limit: 5,
          totalItems: 15,
        ),
        productsDto: [const ProductsDto(id: "10", title: 'Lily')],
      );

      final json = response.toJson();

      expect(json['message'], 'OK');
      expect(json['metadata']['currentPage'], 2);
      expect(json['metadata']['totalPages'], 3);
      expect(json['metadata']['limit'], 5);
      expect(json['metadata']['totalItems'], 15);
      expect(json['products'], isA<List>());
      expect(json['products'].length, 1);
      expect(json['products'][0]['title'], 'Lily');
    });

    test('fromJson handles null values', () {
      final json = {'message': null, 'metadata': null, 'products': null};

      final response = ProductResponse.fromJson(json);

      expect(response.message, isNull);
      expect(response.metadata, isNull);
      expect(response.productsDto, isNull);
    });

    test('toJson handles null values', () {
      final response = ProductResponse();

      final json = response.toJson();

      expect(json['message'], isNull);
      expect(json['metadata'], isNull);
      expect(json['products'], isNull);
    });
  });
}
