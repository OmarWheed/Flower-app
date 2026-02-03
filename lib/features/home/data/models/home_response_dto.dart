import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flower_app/core/app/data/models/product_type_dto.dart';

part 'home_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeResponseDto extends Equatable {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'products')
  final List<ProductsDto>? products;
  @JsonKey(name: 'categories')
  final List<ProductTypeDto>? categories;
  @JsonKey(name: 'bestSeller')
  final List<ProductsDto>? bestSeller;
  @JsonKey(name: 'occasions')
  final List<ProductTypeDto>? occasions;

  const HomeResponseDto({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  factory HomeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseDtoToJson(this);

  @override
  List<Object?> get props => [
    message,
    products,
    categories,
    bestSeller,
    occasions,
  ];
}
