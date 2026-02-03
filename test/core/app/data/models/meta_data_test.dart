import 'package:flower_app/core/app/data/models/meta_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Metadata', () {
    test('creates Metadata with all fields', () {
      final metadata = Metadata(
        currentPage: 1,
        totalPages: 10,
        limit: 20,
        totalItems: 200,
      );

      expect(metadata.currentPage, 1);
      expect(metadata.totalPages, 10);
      expect(metadata.limit, 20);
      expect(metadata.totalItems, 200);
    });

    test('fromJson creates correct Metadata object', () {
      final json = {
        'currentPage': 2,
        'totalPages': 5,
        'limit': 15,
        'totalItems': 75,
      };

      final metadata = Metadata.fromJson(json);

      expect(metadata.currentPage, 2);
      expect(metadata.totalPages, 5);
      expect(metadata.limit, 15);
      expect(metadata.totalItems, 75);
    });

    test('toJson returns correct json map', () {
      final metadata = Metadata(
        currentPage: 3,
        totalPages: 6,
        limit: 30,
        totalItems: 180,
      );

      final json = metadata.toJson();

      expect(json['currentPage'], 3);
      expect(json['totalPages'], 6);
      expect(json['limit'], 30);
      expect(json['totalItems'], 180);
    });

    test('fromJson handles null values', () {
      final json = <String, dynamic>{
        'currentPage': null,
        'totalPages': null,
        'limit': null,
        'totalItems': null,
      };

      final metadata = Metadata.fromJson(json);

      expect(metadata.currentPage, isNull);
      expect(metadata.totalPages, isNull);
      expect(metadata.limit, isNull);
      expect(metadata.totalItems, isNull);
    });

    test('toJson handles null values', () {
      final metadata = Metadata();

      final json = metadata.toJson();

      expect(json['currentPage'], isNull);
      expect(json['totalPages'], isNull);
      expect(json['limit'], isNull);
      expect(json['totalItems'], isNull);
    });
  });
}
