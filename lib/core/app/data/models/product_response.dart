import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'meta_data.dart';

part 'product_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "products")
  final List<ProductsDto>? productsDto;

  ProductResponse({this.message, this.metadata, this.productsDto});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
