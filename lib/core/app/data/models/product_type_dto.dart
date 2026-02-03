import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_type_dto.g.dart';

@JsonSerializable()
class ProductTypeDto extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;

  const ProductTypeDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
  });

  factory ProductTypeDto.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTypeDtoToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    image,
    createdAt,
    updatedAt,
    isSuperAdmin,
  ];
}
