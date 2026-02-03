import 'package:flower_app/features/home/data/models/best_seller_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'best_seller_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BestSellerResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "bestSeller")
  final List<BestSellerDto>? bestSeller;

  BestSellerResponse({this.message, this.bestSeller});

  factory BestSellerResponse.fromJson(Map<String, dynamic> json) {
    return _$BestSellerResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BestSellerResponseToJson(this);
  }
}
