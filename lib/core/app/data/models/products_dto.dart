import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_dto.g.dart';

@JsonSerializable()
class ProductsDto extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'imgCover')
  final String? imgCover;
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'priceAfterDiscount')
  final double? priceAfterDiscount;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'occasion')
  final String? occasion;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;
  @JsonKey(name: 'sold')
  final int? sold;
  @JsonKey(name: 'rateAvg')
  final double? rateAvg;
  @JsonKey(name: 'rateCount')
  final int? rateCount;
  @JsonKey(name: 'discount')
  final double? discount;
  @JsonKey(name: 'alternateId')
  final String? alternateId;

  const ProductsDto({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSuperAdmin,
    this.sold,
    this.rateAvg,
    this.rateCount,
    this.discount,
    this.alternateId,
  });

  factory ProductsDto.fromJson(Map<String, dynamic> json) =>
      _$ProductsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsDtoToJson(this);

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    description,
    imgCover,
    images,
    price,
    priceAfterDiscount,
    quantity,
    category,
    occasion,
    createdAt,
    updatedAt,
    v,
    isSuperAdmin,
    sold,
    rateAvg,
    rateCount,
    discount,
    alternateId,
  ];
}
